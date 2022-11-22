import 'dart:math';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sweet_snackbar/sweet_snackbar.dart';
import 'package:sweet_snackbar/top_snackbar.dart';
import 'package:zona/src/features/view/screens/signIn_signUp_verifyCode_screens/verify_code_screen.dart';
import 'package:zona/src/providers/register_provider.dart';
import 'package:zona/src/utils/responsive.dart';
import 'package:zona/generated/l10n.dart';

import '../../../../config/routing.dart';
import '../../../../utils/app_strings/api_path.dart';
import '../../../../utils/text_input_decoration.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static String id = "sign-up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String gender = 'male';
  String? genderValueLocalized;
  GlobalKey<FormState> key = GlobalKey();
  late RegisterProvider registerProvider;

  @override
  void dispose() {
    phoneController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  AppBar appBar = AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  );

  @override
  Widget build(BuildContext context) {
    registerProvider = Provider.of<RegisterProvider>(context, listen: true);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.getScreenHeightWithoutStatusBarAndAppBar(
                        context, appBar) *
                    0.01),
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "l " + S.current.signUp,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 30),
                            ),
                          ),
                          Form(
                            key: key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    child: Text(
                                      S.current.firstName,
                                      style: TextStyle(
                                          fontSize: Responsive
                                                  .getScreenHeightWithoutStatusBarAndAppBar(
                                                      context, appBar) *
                                              0.03,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    height: Responsive
                                            .getScreenHeightWithoutStatusBarAndAppBar(
                                                context, appBar) *
                                        0.05), //0.05
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.1,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: firstNameController,
                                    cursorColor: Colors.deepPurple,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return S.current.pleaseEnterFirstName;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: kTextFieldDecoration.copyWith(
                                      prefixIconColor: Colors.red,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            right: Responsive
                                                    .getScreenHeightWithoutStatusBarAndAppBar(
                                                        context, appBar) *
                                                0.02),
                                        child: DropdownButton<String>(
                                          value: genderValueLocalized ??
                                              S.current.mr,
                                          dropdownColor: Colors.white,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          underline: Container(
                                            height: Responsive
                                                    .getScreenHeightWithoutStatusBarAndAppBar(
                                                        context, appBar) *
                                                0.02,
                                            color: Colors.transparent,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              genderValueLocalized = newValue!;
                                              gender = mapGenderLocalizedValue(
                                                  genderValueLocalized);
                                            });
                                          },
                                          items: <String>[
                                            S.current.mr, S.current.mrs,
                                            // 'Mr.',
                                            // 'Mrs.'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      hintText: S.current.firstName,
                                    ),
                                  ),
                                ), //0.12+0.05=0.17
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.01,
                                ), //18
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.05,
                                  child: Text(
                                    S.current.lastName,
                                    style: TextStyle(
                                        fontSize: Responsive
                                                .getScreenHeightWithoutStatusBarAndAppBar(
                                                    context, appBar) *
                                            0.03,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ), //23
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.1,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: lastNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return S.current.pleaseEnterLastName;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: kTextFieldDecoration.copyWith(
                                      hintText: S.current.lastName,
                                    ),
                                  ),
                                ), //10+23=33
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.01,
                                ), //1+33=44,
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.05,
                                  child: Text(
                                    S.current.phoneNumber,
                                    style: TextStyle(
                                        fontSize: Responsive
                                                .getScreenHeightWithoutStatusBarAndAppBar(
                                                    context, appBar) *
                                            0.03,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ), //44+5=49*
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.1,
                                  child: TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return S.current.pleaseEnterPhoneNumber;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: kTextFieldDecoration.copyWith(
                                      prefixIcon: CountryCodePicker(
                                        onChanged: print,
                                        initialSelection: 'AE',
                                        showCountryOnly: false,
                                        showOnlyCountryWhenClosed: false,
                                        alignLeft: false,
                                        enabled: false,
                                      ),
                                      hintText: S.current.phoneNumber,
                                    ),
                                  ),
                                ), //49+10=59
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.05,
                                  child: Text(
                                    S.current.email,
                                    style: TextStyle(
                                        fontSize: Responsive
                                                .getScreenHeightWithoutStatusBarAndAppBar(
                                                    context, appBar) *
                                            0.03,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ), //59+5=64
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.1,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return S.current.pleaseEnterEmail;
                                      } else {
                                        return null;
                                      }
                                    },
                                    textInputAction: TextInputAction.next,
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: kTextFieldDecoration.copyWith(
                                      hintText: S.current.email,
                                    ),
                                  ),
                                ), //64+10=74**no validator exist
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.05,
                                  child: Text(
                                    S.current.password,
                                    style: TextStyle(
                                        fontSize: Responsive
                                                .getScreenHeightWithoutStatusBarAndAppBar(
                                                    context, appBar) *
                                            0.03,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ), //74+5=79
                                SizedBox(
                                  height: Responsive
                                          .getScreenHeightWithoutStatusBarAndAppBar(
                                              context, appBar) *
                                      0.1,
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: passwordController,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return S.current.pleaseEnterPassword;
                                      } else if (value.length < 8) {
                                        return S.current
                                            .pleaseEnterPasswordMoreThan8;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: kTextFieldDecoration.copyWith(
                                      //  validator no exist
                                      hintText: S.current.password,
                                    ),
                                  ),
                                ), //79+10=89
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Responsive
                                    .getScreenHeightWithoutStatusBarAndAppBar(
                                        context, appBar) *
                                0.01,
                          ), //89+1=90
                          Container(
                            height: Responsive
                                    .getScreenHeightWithoutStatusBarAndAppBar(
                                        context, appBar) *
                                0.08,
                            color: Colors.white,
                            child: !registerProvider.loading
                                ? MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    height: Responsive
                                            .getScreenHeightWithoutStatusBarAndAppBar(
                                                context, appBar) *
                                        0.08,
                                    minWidth: Responsive
                                            .getScreenHeightWithoutStatusBarAndAppBar(
                                                context, appBar) *
                                        0.08,
                                    color: const Color(0xEFEFEFFF),
                                    child: Text(
                                      S.current.signUp,
                                      style: TextStyle(
                                          fontSize: Responsive
                                                  .getScreenHeightWithoutStatusBarAndAppBar(
                                                      context, appBar) *
                                              0.03,
                                          color: Colors.black),
                                    ),
                                    onPressed: () {
                                      if (key.currentState!.validate()) {
                                        registerProvider.register(
                                            context,
                                            firstNameController.text,
                                            lastNameController.text,
                                            emailController.text,
                                            phoneController.text,
                                            passwordController.text,
                                            gender);
                                      }
                                    },
                                  ) //77
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                          //98
                          SizedBox(
                            height: Responsive
                                    .getScreenHeightWithoutStatusBarAndAppBar(
                                        context, appBar) *
                                0.1, //99
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.current.alreadyHaveAnAccount,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(Responsive
                                            .getScreenHeightWithoutStatusBarAndAppBar(
                                                context, appBar) *
                                        0.01),
                                    child: Text(
                                      S.current.signIn,
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  String generateCode() {
    var rng = Random();
    var code = rng.nextInt(9000) + 1000;

    return code.toString();
  }
}

String mapGenderLocalizedValue(String? genderValueLocalized) {
  if (genderValueLocalized == "سيد" || genderValueLocalized == "Mr.") {
    return "male";
  }
  return "female";
}
