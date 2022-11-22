import 'package:app_settings/app_settings.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:zona/src/features/view/screens/main_app_screens/home_layout_screen/home_layout_screen.dart';
import 'package:zona/src/utils/app_strings/images_pathes.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/responsive.dart';
import '../../components/components.dart';

class NoPermissionFromUserScreen extends StatefulWidget {
  const NoPermissionFromUserScreen({Key? key}) : super(key: key);

  @override
  State<NoPermissionFromUserScreen> createState() =>
      _NoPermissionFromUserScreenState();
}

class _NoPermissionFromUserScreenState
    extends State<NoPermissionFromUserScreen> {
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  late bool locationDone;

  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      return;
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationDone = _serviceEnabled == true && _permissionGranted == PermissionStatus.granted || _permissionGranted == PermissionStatus.grantedLimited;
    print("Location State $locationDone");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Responsive.getScreenWidth(context) * 0.7,
              height: Responsive.getScreenHeight(context) * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetPath.warningImage),
                ),
              ),
            ),
            const Text(
              "Warning",
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "You must make the app access to your Location !!",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Components.defaultPrimaryButton(
              text: "Give Location Permission",
              press: () async {
                await _getUserLocation();
                if(_permissionGranted == PermissionStatus.denied){
                  locationDone = false;
                }else if(_permissionGranted == PermissionStatus.deniedForever)
                {
                  locationDone = false;
                  setState(() {});
                }else
                  {
                    locationDone = true;
                  }
                print("Location State $locationDone");
              },
              color: AppColors.mainColor,
              context: context,
            ),
            Components.defaultPrimaryButton(
              text: "Home Screen",
              press: () async{
                // await _getUserLocation();
                // if (locationDone) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                     HomeScreen.id,
                        (route) => false,
                  );
                // }
              },
              color: AppColors.mainColor,
              context: context,
            ),
            const SizedBox(
              height: 30.0,
            ),
            ConditionalBuilder(
              builder: (context) => Components.defaultPrimaryButton(
                text: "Go settings",
                press: ()async
                {
                  AppSettings.openAppSettings();
                },
                color: AppColors.mainColor,
                context: context,
              ),
              condition: _permissionGranted == PermissionStatus.deniedForever,
              fallback: (context) => const SizedBox(),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
