import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:location/location.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart'
    as handler_permission;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zona/src/core/progress_dialog.dart';
import 'package:zona/src/features/view/screens/NotificationEmptyScreen.dart';
import 'package:zona/src/features/view/screens/terms_of_use_screen/terms_of_use_Screen.dart';
import 'package:zona/src/providers/delete_account_provider.dart';
import 'package:zona/src/providers/home_provider.dart';
import 'package:zona/src/providers/logout_provider.dart';
import 'package:zona/src/utils/responsive.dart';
import '../../../../../utils/colors.dart';
import '../../../../models/user.dart';
import '../../map_screen/map_screen.dart';
import '../dashboard_screen/dashboard.dart';
import 'package:zona/generated/l10n.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../controller/stripe_controller.dart';
import '../../bookings/OrdersPage.dart';
import '../profile_editProfile_screens/ProfileScreen.dart';
import '../profile_editProfile_screens/edit_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String id = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyUser user = MyUser();
  Location location = Location();

  int index = 0;
  int drawerIndex = 0;
  String? address = "";

  var locationData;
  bool locationDone = false;
  bool isGuest = false;
  late HomeProvider homeProvider;

  final Uri _url = Uri.parse('https://zona.ae/privacy-policy');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();

    // Check if permission is granted
    PermissionStatus _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.granted && serviceEnabled) {
      locationData = await Geolocator.getCurrentPosition();

      GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: locationData.latitude,
        longitude: locationData.longitude,
        googleMapApiKey: "AIzaSyCrq81n7DWxfPL_-Dmh8afFw6W0zl6sNm0",
      );

      //Formatted Address
      print(data.address);
      setState(() {
        address = data.address;
      });
      //City Name
      print(data.city);
      //Country Name
      print(data.country);
      //Country Code
      print(data.countryCode);
      //Latitude
      print(data.latitude);
      //Longitude
      print(data.longitude);
      //Postal Code
      print(data.postalCode);
      //State
      print(data.state);
      //Street Number
      print(data.street_number);
    }
  }

  checkLocationIsGranted() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      return;
    }

    if (await handler_permission.Permission.location.status ==
        handler_permission.PermissionStatus.permanentlyDenied) {
      showDialogLocationPermission();
      return;
    }

    handler_permission.PermissionStatus status =
        await handler_permission.Permission.location.request();

    await getCurrentLocation();
    locationDone = serviceEnabled == true &&
        status == handler_permission.PermissionStatus.granted;
    setState(() {});
  }

  showDialogLocationPermission() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Allow app to access your location?'),
        content: const Text('You need to allow location access'),
        actions: <Widget>[
          // if user deny again, we do nothing
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Don\'t allow'),
          ),

          // if user is agree, you can redirect him to the app parameters :)
          TextButton(
            onPressed: () {
              handler_permission.openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Allow'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    getCurrentLocation();
    getUserObject();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getUserObject();
    super.didChangeDependencies();
  }

  getUserObject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isGuest = prefs.getBool("isGuest") ?? false;
    if (!isGuest) {
      if (prefs.getString('user')!.isNotEmpty) {
        user = MyUser.fromJson(json.decode(prefs.getString('user')!));
        debugPrint('TSTS user: ${user.toJson().toString()}');
      } else if (prefs.getString('appleUsername')!.isNotEmpty) {
        user = MyUser(name: prefs.getString('appleUsername'));
      } else if (prefs.getString('googleUsername')!.isNotEmpty) {
        user = MyUser(name: prefs.getString('googleUsername'));
      }
    }
    setState(() {});
  }

  checkProfileImage() {
    return Uri.parse(user.profileImage.toString()).isAbsolute
        ? NetworkImage(user.profileImage.toString())
        : FileImage(File(user.profileImage.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    homeProvider = Provider.of<HomeProvider>(context);
    return ChangeNotifierProvider.value(
      value: homeProvider,
      child: MyProgressDialog(
        inAsyncCall: homeProvider.isLoading,
        child: Scaffold(
          drawer: Drawer(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              color: const Color.fromRGBO(41, 48, 60, 1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Builder(builder: (context) {
                          if (user.profileImage.toString() == 'null') {
                            return Container(
                              height:
                                  Responsive.getScreenHeight(context) * 0.06,
                              width: Responsive.getScreenWidth(context) * 0.11,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(22)),
                              child: const Icon(Icons.person),
                            );
                          } else {
                            return SizedBox(
                              height:
                                  Responsive.getScreenHeight(context) * 0.09,
                              width: Responsive.getScreenWidth(context) * 0.11,
                              child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: checkProfileImage()),
                            );
                          }
                        }),
                      ),
                      title: FutureBuilder(
                          // future: getUser(),
                          builder: (context, snap) {
                        print(user.firstName);
                        return Text(
                          user.firstName.toString() == 'null' ||
                                  user.lastName.toString() == 'null'
                              ? S.current.userName
                              : user.firstName.toString() ==
                                      user.lastName.toString()
                                  ? user.firstName.toString()
                                  : user.firstName.toString() +
                                      " " +
                                      user.lastName.toString(),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.home,
                              color: Color.fromRGBO(41, 48, 60, 1),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            S.current.home,
                            style: const TextStyle(
                                color: Color.fromRGBO(41, 48, 60, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          index = 2;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                IconlyLight.notification,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              S.current.notifications,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _callNumber();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.call_outlined,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              S.current.support,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await checkLocationIsGranted();
                        if (locationDone) {
                          if (prefs.getString('address').toString() == "null") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) => MapScreen(
                                  lat: locationData!.latitude!,
                                  long: locationData!.longitude!,
                                ),
                              ),
                            );
                          } else {
                            final userLocation = jsonDecode(
                                prefs.getString('address').toString());
                            debugPrint('TSTS userLoc: $userLocation');
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) => MapScreen(
                                  long: userLocation['long'],
                                  lat: userLocation['lat'],
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              S.current.address,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (isGuest ? 0 : 20.0),
                    ),
                    isGuest
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: const Text("Are you sure?"),
                                        actions: [
                                          GestureDetector(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColors.mainColor,
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              final provider = Provider.of<
                                                      DeleteAccountProvider>(
                                                  context,
                                                  listen: false);
                                              provider.deleteAccount(context);
                                            },
                                          ),
                                        ],
                                      )));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.transparent),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    S.current.deleteAccount,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => TermsOfUseScreen())));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.book,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              S.current.termsOfUse,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.privacy_tip_outlined,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              S.current.privacyPolicy,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isGuest
                        ? InkWell(
                            onTap: () {
                              final provider = Provider.of<LogoutProvider>(
                                  context,
                                  listen: false);
                              provider.logout(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.transparent),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.login,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    S.current.signIn,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              final provider = Provider.of<LogoutProvider>(
                                  context,
                                  listen: false);
                              provider.logout(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.transparent),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    S.current.logout,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          appBar: index == 0
              ? AppBar(
                  foregroundColor: Colors.black,
                  elevation: 0,
                  toolbarHeight: 60,
                  backgroundColor: Colors.white,
                  title: SizedBox(
                    width: Responsive.getScreenWidth(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Responsive.getScreenWidth(context) * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current.currentLocation,
                                style: const TextStyle(
                                    color: Color.fromRGBO(99, 106, 117, 1),
                                    fontSize: 9),
                              ),
                              SizedBox(
                                // width: 200,
                                child: Text(
                                  address ?? "No Address Found",
                                  style: const TextStyle(
                                      color: Color.fromRGBO(23, 43, 77, 1),
                                      fontSize: 13,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   width: 100,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "BRONZE",
                                  style: TextStyle(
                                      color: Color.fromRGBO(244, 191, 75, 1),
                                      fontSize: 12),
                                ),
                                Text(
                                  "0 POINTS",
                                  style: TextStyle(
                                      color: Color.fromRGBO(99, 106, 117, 1),
                                      fontSize: 10),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 33,
                              child: Image.asset(
                                'assets/images/Badge.png',
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : index == 1
                  ? AppBar(
                      leadingWidth: 0,
                      elevation: 0,
                      backgroundColor: const Color(0xF9F9F9FF),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.iBookings,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 3, 6, 46),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : index == 2
                      ? AppBar(
                          elevation: 0,
                          leadingWidth: 0,
                          backgroundColor: const Color(0xF9F9F9FF),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.current.iNotifications,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 3, 6, 46),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                height: 33,
                                child: RawMaterialButton(
                                  //padding: EdgeInsets.symmetric(horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  fillColor: const Color(0xFFFFFFFF),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.current.recent,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : AppBar(
                          elevation: 0,
                          leadingWidth: 0,
                          backgroundColor: const Color(0xF9F9F9FF),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.current.iProfile,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 3, 6, 46),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (!isGuest)
                                SizedBox(
                                  child: RawMaterialButton(
                                    //padding: EdgeInsets.symmetric(horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    fillColor: const Color(0xFFFFFFFF),
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      MyUser user = MyUser.fromJson(jsonDecode(
                                          prefs.getString('user').toString()));
                                      showBarModalBottomSheet(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        expand: true,
                                        context: context,
                                        elevation: 0,
                                        builder: (context) => EditProfile(
                                          user: user,
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            S.current.editProfile,
                                            textAlign: TextAlign.center,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          const Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
          body: index == 0
              ? const DashBoard()
              : index == 1
                  ? const OrdersPage()
                  : index == 2
                      ? const NotificationEmptyScreen()
                      : ProfileScreen(
                          isGuest: isGuest,
                        ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40),
            child: GNav(
              onTabChange: (int index) async {
                if (index == 0) {
                  await getCurrentLocation();
                }
              },
              selectedIndex: index,
              haptic: true,
              tabBorderRadius: 15,
              curve: Curves.easeOutExpo,
              duration: const Duration(milliseconds: 500),
              gap: 8,
              color: const Color.fromRGBO(111, 118, 126, 1),
              rippleColor: const Color.fromRGBO(26, 27, 45, 1),
              activeColor: const Color.fromRGBO(26, 27, 45, 1),
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              tabs: [
                GButton(
                    icon: Icons.home,
                    text: '',
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        index = 0;
                      });
                    }),
                GButton(
                    icon: Icons.article_rounded,
                    iconSize: 30,
                    text: '',
                    onPressed: () {
                      setState(() {
                        index = 1;
                      });
                    }),
                GButton(
                    icon: IconlyLight.notification,
                    iconSize: 30,
                    text: '',
                    onPressed: () {
                      setState(() {
                        index = 2;
                      });
                    }),
                GButton(
                  icon: Icons.person,
                  iconSize: 30,
                  text: '',
                  curve: Curves.bounceIn,
                  backgroundColor: Colors.grey[200],
                  onPressed: () {
                    setState(
                      () {
                        index = 3;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool?> _callNumber() async {
  const number = '+971508400700'; //set the number here
  return await FlutterPhoneDirectCaller.callNumber(number);
}
