import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sweet_snackbar/sweet_snackbar.dart';
import 'package:sweet_snackbar/top_snackbar.dart';
import 'package:zona/src/api/delete_account_api.dart';
import 'package:zona/src/api/register_api.dart';
import 'package:zona/src/features/controller/social_sign_in_api.dart';
import 'package:zona/src/utils/toast.dart';
import 'package:http/http.dart' as http;
import '../../generated/l10n.dart';
import '../config/routing.dart';
import '../features/view/screens/signIn_signUp_verifyCode_screens/verify_code_screen.dart';
import '../utils/app_strings/api_path.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterApi api = RegisterApi();
  bool loading = false;

  setLoading(bool val){
    loading = val;
    notifyListeners();
  }

  Future register(BuildContext context, String firstName, String lastName,
      String email, String phone, String password, String gender) async {
    setLoading(true);
    api
        .register(firstName, lastName, email, phone, password, gender)
        .then((code) async {
      switch (code) {
        case 200:
          setLoading(false);
          showTopSnackBar(
              context,
              const CustomSnackBar.success(
                  message:
                      'Account created, check your mail for verification code.'));
          Navigator.of(context)
              .push(Routing().createRoute(VerifyCodeScreen(email: email)));
          break;
        case 400:
        case 422:
          setLoading(false);
          showTopSnackBar(context, CustomSnackBar.error(message: S.current.anotherAccountUsesThisEmail + '\n' +
              S.current
                  .pleaseTryAnotherOne));
          break;
        default:
          setLoading(false);
          showTopSnackBar(context, CustomSnackBar.error(message: S.current.connectionError+ '\n' +
              S.current
                  .pleaseTryAnotherOne));
          break;
      }
    });

    notifyListeners();
  }
}
