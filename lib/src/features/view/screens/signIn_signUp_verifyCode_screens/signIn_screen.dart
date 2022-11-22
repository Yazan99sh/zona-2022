import 'dart:convert';
import 'dart:io' show Platform;
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_snackbar/sweet_snackbar.dart';
import 'package:sweet_snackbar/top_snackbar.dart';
import 'package:zona/constants/routes.dart';
import 'package:zona/src/features/controller/social_sign_in.dart';
import 'package:zona/src/features/models/user.dart';
import 'package:zona/src/features/view/screens/signIn_signUp_verifyCode_screens/signUp_screen.dart';
import 'package:zona/src/features/models/login_response.dart';
import 'package:zona/generated/l10n.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zona/src/features/view/screens/signIn_signUp_verifyCode_screens/verify_code_screen.dart';
import 'package:zona/src/utils/app_strings/images_pathes.dart';
import 'package:zona/src/utils/utils.dart';
import '../../../../config/routing.dart';
import '../../../../utils/app_strings/api_path.dart';
import '../../../../utils/text_input_decoration.dart';
import '../block_screens/no_perrmission_selected_or_denied.dart';
import '../main_app_screens/home_layout_screen/home_layout_screen.dart';
import '../../../../utils/colors.dart';
import '../../components/components.dart';
import '../../../../utils/responsive.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static String id = "sign-in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Location location = Location();

  bool? serviceStatue;
  PermissionStatus? permissionStatus;
  late bool locationDone;

  Future getLocationState() async {
    serviceStatue = await location.serviceEnabled();
    permissionStatus = await location.hasPermission();
    locationDone =
        await location.hasPermission() == PermissionStatus.grantedLimited &&
                    serviceStatue == true ||
                await location.hasPermission() == PermissionStatus.granted &&
                    serviceStatue == true
            ? true
            : false;
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool loading = false;

  @override
  void initState() {
    getLocationState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.getScreenWidth(context) * 0.03,
            ),
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.0575,
                  ),
                  Image.asset(
                    "assets/images/ZonaLogo.png",
                    fit: BoxFit.contain,
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.15,
                    //  width: Responsive.getScreenWidth(context)*0.1,
                  ), // Logo image
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.0575,
                  ),
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.08,
                    child: Text(
                      "l " + S.current.signIn,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ), // sign in text
                  // SizedBox(
                  //   height:
                  //       Responsive.getScreenHeightWithoutStatusBar(context) *
                  //           0.07,
                  //   child: Text(
                  //     S.current.emailAddress,
                  //     style: const TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ), // email text
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.08,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.current.pleaseEnterEmail;
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: S.current.email,
                      ),
                    ), //  Email TextForm
                  ), // email TextForm
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.015, //50
                  ),
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.08,
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.current.pleaseEnterPassword;
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      controller: passwordController,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: S.current.password,
                      ),
                    ),
                  ), // Password TextForm
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.015,
                  ),
                  Container(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.06,
                    width: Responsive.getScreenHeight(context) * 0.02,
                    color: Colors.white,
                    child: !loading
                        ? Components.defaultPrimaryButton(
                            text: S.current.signIn,
                            press: () async {
                              if (key.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                http.post(
                                    Uri.parse(ApiPath.baseAuthUrl + "login"),
                                    body: {
                                      "email": emailController.text,
                                      "password": passwordController.text
                                    }).then(
                                  (value) async {
                                    loginRes(value);
                                  },
                                ).onError((error, stackTrace) {
                                  showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                          message:
                                              S.current.loginAttemptFailed +
                                                  '\n' +
                                                  S.current.pleaseTryAgain,
                                          backgroundColor: Colors.black));
                                  setState(() {
                                    loading = false;
                                  });
                                  print(error);
                                });
                              }
                            },
                            color: AppColors.mainColor,
                            context: context)
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                  ), // Login Button
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.1,
                  ),
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.04,
                    child: Text(
                      S.current.signInWith,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ), // Sign in with Text
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.08, //76
                    width: Responsive.getScreenHeightWithoutStatusBar(context) *
                        0.08,
                    child:
                        // Platform.isAndroid
                        //     ? Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [googleButton()],
                        //       )
                        //     :
                        Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(child: googleForIosButton()),
                        const SizedBox(width: 20),
                        // const Text("or"),
                        Flexible(child: appleButton()),
                      ],
                    ),
                  ), // google & iphone Login
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.02,
                  ),
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.06,
                    child: RawMaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: const Color(0xFCFCFCFF),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool("isGuest", true);
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            locationDone ? HomeScreen.id : noPermissionRoute,
                            (route) => false);
                      },
                      child: Text(S.current.continueAsAGuest),
                    ),
                  ), // continue as guest button
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.02,
                  ),
                  SizedBox(
                      height:
                          Responsive.getScreenHeightWithoutStatusBar(context) *
                              0.05),
                  SizedBox(
                    height:
                        Responsive.getScreenHeightWithoutStatusBar(context) *
                            0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.current.createANewAccount,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              Routing().createRoute(
                                const SignUpScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              S.current.signUp,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ), // create new account and sign up button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  googleButton() {
    return GestureDetector(
      onTap: () {
        final provider =
            Provider.of<SocialSignInProvider>(context, listen: false);
        provider.googleLogin(context, locationDone);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.getScreenWidth(context) * 0.02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xEFEFEFFF), width: 2)),
        height: Responsive.getScreenHeightWithoutStatusBar(context) * 0.08,
        width: Responsive.getScreenHeightWithoutStatusBar(context) * 0.08,
        child: SvgPicture.asset(
          AssetPath.googleImage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  googleForIosButton() {
    return GestureDetector(
        onTap: () {
          final provider = !Platform.isAndroid
              ? Provider.of<SocialSignInProvider>(context, listen: false)
              : Provider.of<SocialSignInProvider>(context, listen: false);
          provider.googleLogin(context, locationDone);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                AssetPath.googlePngImage,
              ),
            ),
          ),
        )

        //  Container(
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(50),
        //       border: Border.all(color: const Color(0xEFEFEFFF), width: 2)),
        //   height: Responsive.getScreenHeightWithoutStatusBar(context) * 0.08,
        //   // width: Responsive.getScreenHeightWithoutStatusBar(context) * 0.25,
        //   child: Row(
        //     children: [
        //       const SizedBox(width: 5),
        //       Image.asset(
        //         AssetPath.googlePngImage,
        //         height:
        //             Responsive.getScreenHeightWithoutStatusBar(context) * 0.03,
        //         fit: BoxFit.cover,
        //       ),
        //       const SizedBox(width: 10),
        //       // Expanded(
        //       //   child: Text(S.current.signInWithGoogle,
        //       //       style: const TextStyle(color: Colors.black, fontSize: 14)),
        //       // )
        //     ],
        //   ),
        // ),
        );
  }

  appleButton() {
    return GestureDetector(
        onTap: () {
          if (!Platform.isAndroid) {
            final provider =
                Provider.of<SocialSignInProvider>(context, listen: false);
            provider.signInWithApple(context, locationDone);
          } else {}
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                AssetPath.appleImage,
              ),
            ),
          ),
        )

        // Container(
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(color: const Color(0xEFEFEFFF), width: 2)),
        //   height: Responsive.getScreenHeightWithoutStatusBar(context) * 0.08,
        //   width: Responsive.getScreenHeightWithoutStatusBar(context) * 0.25,
        //   child: Row(
        //     children: [
        //       Image.asset(
        //         AssetPath.appleImage,
        //         height:
        //             Responsive.getScreenHeightWithoutStatusBar(context) * 0.05,
        //         fit: BoxFit.cover,
        //       ),
        //       // Expanded(
        //       //   child: Text(S.current.signInWithApple,
        //       //       style: const TextStyle(color: Colors.black, fontSize: 14)),
        //       // )
        //     ],
        //   ),
        // ),
        );
  }

  loginRes(Response value) async {
    setState(() {
      loading = false;
    });
    if (value.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = jsonDecode(value.body);
      prefs.setString('token', data['data']['token']);
      MyUser user = MyUser.fromJson(data['data']['user']);
      prefs.setString('user', json.encode(user.toJson()));

      if (user.verified! == "1") {
        verifiedUser();
      } else {
        unVerifiedUser();
      }
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(message: S.current.wrongEmailOrPassword),
      );
    }
  }

  verifiedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Logged', true);
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: S.current.loggedSuccessfully,
        backgroundColor: Colors.black,
      ),
    );
    prefs.setBool("isGuest", false);
    Navigator.of(context).push(
      Routing().createRoute(
        ConditionalBuilder(
          builder: (context) => const HomeScreen(),
          // fallback: (context) => const NoPermissionFromUserScreen(),
          fallback: (context) => const HomeScreen(),
          condition: locationDone,
        ),
      ),
    );
  }

  unVerifiedUser() {
    Navigator.of(context).push(
        Routing().createRoute(VerifyCodeScreen(email: emailController.text)));
  }
}
