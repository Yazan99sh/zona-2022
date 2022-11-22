import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zona/src/utils/colors.dart';
import 'package:zona/src/utils/responsive.dart';
import '../../../../../generated/l10n.dart';
import '../../../../utils/app_strings/images_pathes.dart';
import '../signIn_signUp_verifyCode_screens/signIn_screen.dart';
import '../../../../config/routing.dart';
import '../../components/components.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final PageController controller = PageController();
  final int onBoardScreenCount = 3;
  bool inLastScreen = false;
  bool isMoveNextPage = true;
  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Expanded(
            flex: 8,
            child: PageView(
              onPageChanged: (v) {
                setState(() {
                  currentPage = v;
                });
              },
              controller: controller,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      OnBoardingPage(
                        controller: controller,
                        onBoardScreenCount: onBoardScreenCount,
                        imagePath: AssetPath.onBoardingFirstImage,
                        label: S.current.beautySalonService,
                      ),
                      GestureDetector(
                        onTap: (() {
                          controller.animateToPage(
                            onBoardScreenCount,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          setState(
                            () {
                              inLastScreen = true;
                            },
                          );
                        }),
                        child: const SkipButton(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      OnBoardingPage(
                        controller: controller,
                        onBoardScreenCount: onBoardScreenCount,
                        imagePath: AssetPath.onBoardingSecondImage,
                        label: S.current.carWasherService,
                      ),
                      GestureDetector(
                        onTap: (() {
                          print(12);

                          controller.animateToPage(
                            onBoardScreenCount,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          setState(
                            () {
                              inLastScreen = true;
                            },
                          );
                        }),
                        child: const SkipButton(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      OnBoardingPage(
                        controller: controller,
                        onBoardScreenCount: onBoardScreenCount,
                        imagePath: AssetPath.onBoardingThirdImage,
                        label: S.current.cleaningServices,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (currentPage < 2) {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('SeenIntro', true).then(
                        (value) {
                          debugPrint(
                              'TSTS SeenIntro: ${prefs.getBool('SeenIntro')}');
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            SignInScreen.id,
                            (Route<dynamic> route) => false,
                          );
                        },
                      );
                    }
                  },
                  child: currentPage != 2
                      ? CircleAvatar(
                          backgroundColor: AppColors.mainColor,
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                            size: 40,
                          ),
                          radius: 30,
                        )
                      : Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: FittedBox(
                            child: Text(
                              "Get Started",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                        ),
                ),
              ],
            ),
            flex: 2,
          )
        ],
      ),
    );

    // Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Center(
    //     child: Container(
    //       padding: const EdgeInsets.only(
    //         bottom: 60.0,
    //       ),
    //       child: PageView(
    //         onPageChanged: (index) {
    //           if (onBoardScreenCount - 1 == index) {
    //             isMoveNextPage = false;
    //           } else {
    //             isMoveNextPage = true;
    //           }
    //         },
    //         physics: const BouncingScrollPhysics(),
    //         controller: controller,
    //         children: [
    //           Components.defaultPageOnBoard(
    //             context: context,
    //             imagePath: AssetPath.onBoardingFirstImage,
    //             lable: S.current.beautySalonService,
    //             title: S.current.makeUp,
    //           ),
    //           Components.defaultPageOnBoard(
    //             context: context,
    //             imagePath: AssetPath.onBoardingSecondImage,
    //             lable: S.current.carWasherService,
    //             title: S.current.carWasher,
    //           ),
    //           Components.defaultPageOnBoard(
    //             context: context,
    //             imagePath: AssetPath.onBoardingThirdImage,
    //             lable: S.current.onDemandHomeService,
    //             title: S.current.cleaner,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   bottomSheet: Container(
    //     color: Colors.white,
    //     height: Responsive.getScreenHeight(context) * 0.1,
    //     // color: Colors.purple,
    //     child: Row(
    //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         ConditionalBuilder(
    //           condition: !inLastScreen,
    //           fallback: (context) => const Spacer(
    //             flex: 15,
    //           ),
    //           builder: (context) => Components.defaultButtonOnBoard(
    //             context: context,
    //             lable: S.current.skip,
    //             onPress: () {
    //               controller.animateToPage(
    //                 onBoardScreenCount,
    //                 duration: const Duration(milliseconds: 500),
    //                 curve: Curves.easeInOut,
    //               );
    //               setState(() {
    //                 inLastScreen = true;
    //               });
    //             },
    //           ),
    //         ),
    //         const Spacer(),
    //         SmoothPageIndicator(
    //           controller: controller,
    //           count: onBoardScreenCount,
    //           effect: WormEffect(
    //             spacing`: 7,
    //             dotColor: Colors.black12,
    //             dotHeight: 7.0,
    //             dotWidth: 10.0,
    //             activeDotColor: AppColors.mainColor,
    //           ),
    //         ),
    //         const Spacer(),
    //         Components.defaultButtonOnBoard(
    //           context: context,
    //           lable: S.current.next,
    //           onPress: () async {
    //             if (isMoveNextPage) {
    //               controller.nextPage(
    //                 duration: const Duration(milliseconds: 500),
    //                 curve: Curves.easeInOut,
    //               );
    //             } else {

    //               SharedPreferences prefs =
    //                   await SharedPreferences.getInstance();
    //               prefs.setBool('SeenIntro', true).then(
    //                 (value) {
    //                   debugPrint(
    //                       'TSTS SeenIntro: ${prefs.getBool('SeenIntro')}');
    //                   Navigator.pushNamedAndRemoveUntil(
    //                     context,
    //                     SignInScreen.id,
    //                     (Route<dynamic> route) => false,
    //                   );
    //
    // },
    //               );
    //             }
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(20)),
          child: const Center(
            child: FittedBox(
              child: Text("Skip"),
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    Key? key,
    required this.controller,
    required this.onBoardScreenCount,
    required this.imagePath,
    required this.label,
  }) : super(key: key);

  final PageController controller;
  final int onBoardScreenCount;
  final String imagePath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: Responsive.getScreenWidth(context),
          height: Responsive.getScreenHeight(context) * 0.55,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imagePath), fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmoothPageIndicator(
            controller: controller,
            count: onBoardScreenCount,
            effect: WormEffect(
              spacing: 7,
              dotColor: Colors.black12,
              dotHeight: 7.0,
              dotWidth: 10.0,
              activeDotColor: AppColors.mainColor,
            ),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.francoisOne(
            textStyle: const TextStyle(fontSize: 33),
          ),
          maxLines: 2,
        )
      ],
    );
  }
}
