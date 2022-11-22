import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
import 'package:zona/src/features/controller/social_sign_in_api.dart';
import 'package:zona/src/utils/toast.dart';

import '../../../generated/l10n.dart';
import '../../config/routing.dart';
import '../view/screens/block_screens/no_perrmission_selected_or_denied.dart';
import '../view/screens/main_app_screens/home_layout_screen/home_layout_screen.dart';

class SocialSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final SocialSignInApi socialSignInApi = SocialSignInApi();

  Future googleLogin(BuildContext context, bool locationDone) async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      final result = await googleSignIn.signIn();
      final auth = await result!.authentication;
      socialSignInApi
          .loginSocialUser('google', auth.accessToken!)
          .then((code) async {
        switch (code) {
          case 200:
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('googleUsername', result.displayName!);
            loginSocialUserSuccessful(context, locationDone);
            break;
          case 400:
            showTopSnackBar(
                context,
                const CustomSnackBar.error(
                    message: 'There is a problem with login'));
            break;
          default:
            showTopSnackBar(context,
                CustomSnackBar.error(message: S.current.connectionError));
            break;
        }
      });
    } catch (error) {
      debugPrint('TSTS error ${error.toString()}');
    }
  }

  Future signInWithApple(BuildContext context, bool locationDone) async {
    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      // nonce: nonce,
    );

    print('TSTS email: ${appleCredential.email}');
    print('TSTS name: ${appleCredential.givenName}');
    print('TSTS token: ${appleCredential.identityToken}');

    socialSignInApi
        .loginSocialUser('apple', appleCredential.identityToken!)
        .then((code) async {
      switch (code) {
        case 200:
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('appleUsername', appleCredential.givenName ?? '');
          loginSocialUserSuccessful(context, locationDone);
          break;
        case 400:
          showTopSnackBar(
              context,
              const CustomSnackBar.error(
                  message: 'There is a problem with login'));
          break;
        default:
          showTopSnackBar(context,
              CustomSnackBar.error(message: S.current.connectionError));
          break;
      }
    });
    notifyListeners();
  }

  loginSocialUserSuccessful(BuildContext context, bool locationDone) async {
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
}
