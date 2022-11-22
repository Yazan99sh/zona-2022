
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zona/constants/constants.dart';

import '../utils/app_strings/api_path.dart';
import '../utils/utils.dart';

class LogoutApi {
  static BaseOptions options = BaseOptions(
    contentType: Headers.formUrlEncodedContentType,
  );
  Dio dio = Dio(options);

  Future<int> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    int resCode = 0;
    try {
      await dio
          .post(ApiPath.logout,
          data: {"token": token},
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $token'
          }))
          .then((res) {
        resCode = successCode;
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