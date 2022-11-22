import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zona/constants/constants.dart';
import 'package:zona/src/utils/utils.dart';

import '../../utils/app_strings/api_path.dart';
import '../models/user.dart';

class SocialSignInApi {
  static BaseOptions options = BaseOptions(
    contentType: Headers.formUrlEncodedContentType,
  );
  Dio dio = Dio(options);

  Future<int> loginSocialUser(String type, String sToken) async {
    int resCode = 0;
    final prefs = await SharedPreferences.getInstance();

    try {
      await dio
          .post(ApiPath.socialLogin,
              queryParameters: {
                'type': type,
                's_token': sToken,
              },
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json"
              }))
          .then((res) async {
        debugPrint('TSTS user: ${res.data}');
        await prefs.setString('token', res.data['data']['token']);
        MyUser user = MyUser.fromJson(res.data['data']['user']);
        await prefs.setString('user', json.encode(user.toJson()));
        resCode = successCode;
      });
    } on DioError catch (e) {
      debugPrint("TSTS " + e.response.toString());
      if (Utils.catchErrorConnection(e)) {
        resCode = networkErrorCode;
      } else {
        resCode = e.response!.statusCode!;
      }
    }

    return resCode;
  }
}
