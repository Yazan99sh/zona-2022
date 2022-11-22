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
import 'package:zona/src/features/controller/social_sign_in_api.dart';
import 'package:zona/src/utils/toast.dart';

import '../../generated/l10n.dart';
import '../features/view/screens/signIn_signUp_verifyCode_screens/signIn_screen.dart';

class DeleteAccountProvider extends ChangeNotifier {
  final DeleteAccountApi api = DeleteAccountApi();

  Future deleteAccount(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    api.deleteAccount().then((code) async {
      switch (code) {
        case 200:
          showTopSnackBar(
              context, CustomSnackBar.error(message: S.current.accountDeleted));

          prefs.setBool('Logged', false);
          prefs.setString('token', '');
          prefs.setString('user', '');

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false);
          break;
        case 400:
          MyToast.showToast("There is a problem with login");
          break;
        default:
          showTopSnackBar(context,
              CustomSnackBar.error(message: S.current.connectionError));
          break;
      }
    });

    notifyListeners();
  }
}
