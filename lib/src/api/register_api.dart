import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zona/constants/constants.dart';

import '../features/models/user.dart';
import '../utils/app_strings/api_path.dart';
import '../utils/utils.dart';

class RegisterApi {
  static BaseOptions options = BaseOptions(
    contentType: Headers.formUrlEncodedContentType,
  );
  Dio dio = Dio(options);

  Future<int> register(String firstName, String lastName, String email,
      String phone, String password, String gender) async {
    int resCode = 0;
    try {
      await dio
          .post(ApiPath.baseAuthUrl + "register",
              data: {
                "first_name": firstName,
                "last_name": lastName,
                "phone": "+971" + phone,
                "email": email,
                "password": password,
                "gender": gender,
                'verified': '0'
              },
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json"
              }))
          .then((res) async{
        resCode = successCode;
        final data = res.data;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', data['data']['token']);

        MyUser user = MyUser.fromJson(data['data']['user']);
        prefs.setString('user', json.encode(user.toJson()));
      });
    } on DioError catch (e) {
      print("TSTS " + e.response.toString());
      if (Utils.catchErrorConnection(e)) {
        resCode = networkErrorCode;
      } else {
        resCode = e.response!.statusCode!;
      }
    }

    return resCode;
  }
}
