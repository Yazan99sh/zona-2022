import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zona/src/core/progress_dialog.dart';
import 'package:zona/src/features/models/serviceprovider.dart';
import 'package:zona/src/features/models/service.dart';
import 'package:zona/src/features/view/screens/bookings/AllCategoriesScreen.dart';
import 'package:zona/src/features/view/widgets/LoadingIndicatorWidget.dart';
import 'package:zona/src/providers/draft_provider.dart';
import 'package:zona/src/providers/home_provider.dart';
import 'package:zona/src/utils/colors.dart';
import 'package:zona/src/utils/translator.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../providers/logout_provider.dart';
import '../../../../../utils/responsive.dart';
import '../../../../models/category.dart';
import '../../../../../config/routing.dart';
import '../../ServiceDetailsScreen.dart';
import '../../SubCategoriesScreen.dart';
import 'package:zona/generated/l10n.dart';
import 'package:provider/provider.dart' as pvd;

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key, this.user}) : super(key: key);
  final user;

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late HomeProvider homeProvider;
  final TextEditingController _phoneController = TextEditingController();
  final List<String> name = [
    'U ... UP\nSpecial',
    'Main\nCategory2',
    'Main\nCategory3',
    'Main\nCategory4',
    'Main\nCategory5',
    'Main\nCategory6',
    'Main\nCategory7',
  ];
  int index = 0;
  List<Category> categories = [];
  List<Services> services = [];

  List<String> carouselItemsPath = [];

  final String? baseURL = "http://new.zona.ae";

  bool isLoading = true;

  Future<void> getSliderPhotos() async {
    setLoading(true);
    final response =
        await http.get(Uri.parse(baseURL! + "/api/offers/all-offers"));
    List<dynamic> photos = jsonDecode(response.body);
    setState(() {
      for (var element in photos) {
        carouselItemsPath.add(
          element['img'],
        );
      }
    });
  }

  setLoading(bool val) {
    homeProvider.setLoading(val);
  }

  @override
  void initState() {
    final provider = Provider.of<DraftProvider>(context, listen: false);
    provider.getDrafts(476);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeProvider = pvd.Provider.of<HomeProvider>(context, listen: false);
      callApi();
    });
  }

  callApi() async {
    getSliderPhotos();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        appBar: null,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                /// Slider
                sliderPhotos(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Colors.white,
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(15.0),
                //         child: Column(
                //           children: [
                //             Row(
                //               children: const [
                //                 Text(
                //                   "HELLO KHALED",
                //                   style: TextStyle(fontWeight: FontWeight.bold),
                //                 ),
                //                 Icon(
                //                   Icons.waving_hand_rounded,
                //                   color: Color.fromARGB(255, 236, 174, 4),
                //                 )
                //               ],
                //             ),
                //             Text(
                //               "What you are looking for today",
                //               style: TextStyle(
                //                   fontSize: Responsive.getScreenWidth(context) *
                //                       0.084,
                //                   color: kIconBgColor,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.symmetric(vertical: 10),
                //               child: TextField(
                //                 decoration: InputDecoration(
                //                   filled: true,
                //                   fillColor: kbgColor,
                //                   hintText: "Search what you need...",
                //                   contentPadding: const EdgeInsets.symmetric(
                //                       horizontal: 20),
                //                   border: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(10)),
                //                   focusedBorder: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(10),
                //                       borderSide: const BorderSide(
                //                           color: kIconBgColor, width: 2)),
                //                   suffixIcon: Padding(
                //                     padding: const EdgeInsets.symmetric(
                //                         vertical: 4, horizontal: 4),
                //                     child: Container(
                //                         decoration: BoxDecoration(
                //                           borderRadius:
                //                               BorderRadius.circular(10),
                //                           color: kIconBgColor,
                //                         ),
                //                         child: const Icon(
                //                           Icons.search,
                //                           color: Colors.white,
                //                         )),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       )),
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: Responsive.getScreenWidth(context),
                    height: Responsive.getScreenHeight(context) * 0.15,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          categoryList(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CategoriesScreen(
                                      categories: categories)));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius:
                                      Responsive.getScreenWidth(context) * 0.08,
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.grey,
                                  ),
                                  backgroundColor: kbgColor,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Text(
                                    "See All",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  // padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                  width: Responsive.getScreenWidth(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                  ),
                  child: servicesList(),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  categoryList() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.isEmpty ? 0 : categories.sublist(0, 3).length,
        itemBuilder: (BuildContext context, int index) {
          String color = '0x' + categories[index].color.toString();
          return categories.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              Routing().createRoute(
                                CategoryProviders(
                                  dashboardView: false,
                                  idCategory: categories[index].id.toString(),
                                  categoryName: categories[index].name,
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(
                              int.parse(color),
                            ),
                            // backgroundImage:
                            radius: Responsive.getScreenWidth(context) * 0.08,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.network(
                                categories[index].image.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      FutureBuilder(
                          future: Translator.translateService(
                              categories[index].name.toString(), context),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            return ConditionalBuilder(
                              condition: snapshot.hasData,
                              builder: (context) => Text(
                                snapshot.data,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(65, 64, 93, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                              fallback: (context) =>
                                  JumpingDotsProgressIndicator(
                                fontSize: 20.0,
                              ),
                            );
                          }),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        },
      ),
    );
  }

  sliderPhotos() {
    return Container(
      height: Responsive.getScreenHeight(context) * 0.23,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: SizedBox(
        child: carouselItemsPath.isNotEmpty
            ? CarouselSlider.builder(
                itemBuilder: (BuildContext context, int index, int index2) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      carouselItemsPath[index],
                      fit: BoxFit.fill,
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 1,
                  aspectRatio: 2,
                  autoPlayInterval: const Duration(seconds: 3),
                  initialPage: 0,
                  // height: Responsive.getScreenHeight(context) * 0.8,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                itemCount: carouselItemsPath.length,
              )
            : const SizedBox(),
      ),
    );
  }

  servicesList() {
    return SizedBox(
      width: Responsive.getScreenWidth(context),
      height: 340.0 * categories.length,
      child: ListView.builder(
        itemCount: categories.length,
        shrinkWrap: false,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: Responsive.getScreenWidth(context),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Category Name
                        FutureBuilder(
                            future: Translator.translateService(
                                categories[index].name.toString(), context),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              return ConditionalBuilder(
                                condition: snapshot.hasData,
                                builder: (context) => Text(
                                  "l " + snapshot.data,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(23, 43, 77, 1),
                                  ),
                                ),
                                fallback: (context) =>
                                    JumpingDotsProgressIndicator(
                                  numberOfDots: 5,
                                  fontSize: 20.0,
                                ),
                              );
                            }),

                        /// See All Button
                        SizedBox(
                          height: 33,
                          child: RawMaterialButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            fillColor: const Color.fromRGBO(255, 255, 255, 1),
                            onPressed: () {
                              Navigator.of(context).push(
                                Routing().createRoute(
                                  CategoryProviders(
                                    idCategory: categories[index].id.toString(),
                                    categoryName: categories[index].name,
                                    dashboardView: false,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.current.seeAll,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(111, 118, 126, 1),
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color.fromRGBO(111, 118, 126, 1),
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// List Category Related Services
                    CategoryProviders(
                      idCategory: categories[index].id.toString(),
                      categoryName: categories[index].name,
                      dashboardView: true,
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List<Category>> getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    debugPrint('TSTS getCategories');

    http.post(Uri.parse('$baseURL/api/auth/categories'),
        headers: {"Authorization": 'Bearer $token'},
        body: {"token": token}).then((value) {
      try {
        setState(() {
          var data = jsonDecode(value.body);
          Iterable l = data['data'];
          categories =
              List<Category>.from(l.map((model) => Category.fromJson(model)));
          debugPrint('TSTS categories: ${categories.length}');
        });
        getServices();
      } catch (e) {
        debugPrint('TSTS error1: $e');
      }
    }).onError((error, stackTrace) {
      debugPrint('TSTS error: $error');
    });
    return categories;
  }

  Future<void> getServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    bool isGuest = prefs.getBool("isGuest") ?? false;
    final String? servicesURL = "$baseURL/api/auth/all_services";
    debugPrint('TSTS token: $token');

    http.post(Uri.parse(servicesURL!),
        headers: {"Authorization": 'Bearer $token'}).then((value) {
      debugPrint('TSTS code: ${value.statusCode}');
      if (value.statusCode == 200) {
        setState(() {
          var data = jsonDecode(value.body);
          Iterable l = data['data'];
          debugPrint("iterable:\t$l");
          services =
              List<Services>.from(l.map((model) => Services.fromJson(model)));
        });
      } else if (value.statusCode == 401 && !isGuest) {
        /// refresh token
        final provider =
            pvd.Provider.of<LogoutProvider>(context, listen: false);
        provider.logout(context);
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      print('TSTS getServicesError: ${error.toString()} $stackTrace');
    });
  }
}
