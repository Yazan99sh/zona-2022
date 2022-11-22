import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zona/src/features/models/NGeniusPaymentModel.dart';
import 'package:zona/src/features/models/PaymentSharedClass.dart';
import 'package:zona/src/utils/utils.dart';

import '../../../../constants/constants.dart';

class NGenuisPaymentService {
  // static const String? API_KEY =
  //     "ZWNmYTA3YmItOGZhNC00YjkwLTk2ODItODhhODc1NmUzMDY3OmM5ZjZkMzhhLTE3ZjgtNDZhNS1hMjgzLTllYmVlYTBiMTQzMA==";
  //
  // static const String? OUTLET_REF = "7d2f06be-897b-4cd6-b0be-ebc63a244c3e";
  //
  // static const String? getAccessTokenURL =
  //     "https://api-gateway.ngenius-payments.com/identity/auth/access-token";
  //
  // static const String? oneStagePaymentURL =
  //     "https://api-gateway.ngenius-payments.com/transactions/outlets/$OUTLET_REF/payment/card";
  //
  // static const String? createOrderURL =
  //     'https://api-gateway.ngenius-payments.com/transactions/outlets/$OUTLET_REF/orders';
  static const String? createPaymentURL =
      'http://new.zona.ae/public/api/user/store_payment';

  // static Map<String, String> getTokenRequestHeaders() => {
  //       "accept": "application/vnd.ni-identity.v1+json",
  //       "authorization": "Bearer ${PaymentSharedClass.accessToken}",
  //       "content-type": "application/vnd.ni-identity.v1+json"
  //     };
  //
  // static Map<String, String> getKeyRequestHeaders() => {
  //       "accept": "application/vnd.ni-identity.v1+json",
  //       "authorization": "Basic $API_KEY",
  //       "content-type": "application/vnd.ni-identity.v1+json"
  //     };
  //
  // static Future<String> getAccessToken() async {
  //   log("********FROM GET ACCESS TOKEN******");
  //   log("API URL:\t$getAccessTokenURL");
  //   try {
  //     final response = await http.post(Uri.parse(getAccessTokenURL!),
  //         headers: getKeyRequestHeaders());
  //     final responseData = jsonDecode(response.body) as Map;
  //     log("Response Data:\t$responseData");
  //     if (responseData.containsKey('code')) {
  //       return responseData['code'].toString();
  //     } else {
  //       return responseData['access_token'];
  //     }
  //   } on Exception catch (e) {
  //     log(e.toString());
  //     return e.toString();
  //   }
  // }
  //
  // static Future<dynamic> createOrder(
  //     {Map<String, dynamic>? requestBody}) async {
  //   final Map<String, String> orderHeaders = {
  //     "accept": "application/vnd.ni-payment.v2+json",
  //     "authorization": "Bearer ${PaymentSharedClass.accessToken}",
  //     "content-type": "application/vnd.ni-payment.v2+json"
  //   };
  //
  //   print("********FROM Create Order API******");
  //   print("API URL:\t$createOrderURL");
  //   print("Request Body:\t$requestBody");
  //
  //   try {
  //     final response = await http.post(Uri.parse(createOrderURL!),
  //         body: jsonEncode(requestBody), headers: orderHeaders);
  //     print("ResponseObject:\t${jsonDecode(response.body)}");
  //     NGeniusPaymentModel returnedPaymentResponse =
  //         NGeniusPaymentModel.formJSON(
  //             jsonDecode(response.body) as Map<String, dynamic>);
  //     return returnedPaymentResponse;
  //   } on TimeoutException catch (e) {
  //     return e.message;
  //   } on SocketException catch (e) {
  //     return e.message;
  //   } on FormatException catch (e) {
  //     return e.message;
  //   } on HandshakeException catch (e) {
  //     return e.message;
  //   } on HttpException catch (e) {
  //     return e.message;
  //   }
  // }

  static Future<dynamic> storePayment(
      {Map<String, dynamic>? requestBody}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    Dio dio = Dio();
    try {
      await dio
          .post(createPaymentURL!,
              data: requestBody,
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json",
                "Authorization": "Bearer $token",
              }))
          .then((res) {
        return jsonDecode(res.data);
      });
    } on DioError catch (e) {
      print("TSTS err: " + e.response.toString());
      return e.response!;
    }
  }

  static Future<String> doFirstStep3D(
      {Map<String, dynamic>? requestBody, String? url}) async {
    final Map<String, String> paymentHeaders = {
      "accept": "application/x-www-form-urlencoded",
      "content-type": "application/x-www-form-urlencoded"
    };

    print("********FROM First 3D Step ******");
    print("API URL:\t$url");
    print("Request Body:\t$requestBody");

    try {
      final response = await http.post(Uri.parse(url!),
          body: requestBody, headers: paymentHeaders);
      return response.body;
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
