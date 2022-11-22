
import 'package:dio/dio.dart';

class Utils {
  static bool catchErrorConnection(DioError e) {
    bool isError = false;
    switch (e.type) {
      case DioErrorType.connectTimeout:
        print('CONNECT_TIMEOUT');
        isError = true;
        break;
      case DioErrorType.sendTimeout:
        print('SEND_TIMEOUT');
        isError = true;
        break;
      case DioErrorType.receiveTimeout:
        print('RECEIVE_TIMEOUT');
        isError = true;
        break;
      case DioErrorType.response:
        print('RESPONSE');
        break;
      case DioErrorType.cancel:
        print('CANCEL');
        break;
      case DioErrorType.other:
        print('DEFAULT_NETWORK_ERROR');
        isError = true;
        break;
    }
    return isError;
  }
}