import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zona/src/features/controller/services/NGenuisPayment.dart';
import 'package:zona/src/features/models/order.dart';
import 'package:zona/src/utils/fixed_number.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment({
    required String amount,
    required String currency,
    required BillingDetails billingDetails,
    Order? order,
    Function()? callBack,
    required Function() stopLoadingCallBack,
  }) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                merchantDisplayName: 'Zona',
                // applePay: const PaymentSheetApplePay(
                //   merchantCountryCode: 'AE',
                //   // you can add invoice details here
                // ),
                customerId: paymentIntentData!['customer'],
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
                billingDetails: billingDetails));
        displayPaymentSheet(
            order: order,
            callBack: () {
              if (callBack != null) {
                callBack();
              }
            });
        stopLoadingCallBack();
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet({Order? order, Function()? callBack}) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      /// here call api to save your payments in your database
      await storePayment(
              orderId: order?.id ?? -1,
              status: 'success',
              amount: order?.totalPrice,
              transactionId: '${order?.id}_${DateTime.now().toIso8601String()}')
          .whenComplete(() {
        if (callBack != null) {
          callBack();
        }
      });
    } on Exception catch (e) {
      debugPrint('TSTS error payment: ${e.toString()}');
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                // 'Bearer sk_test_51LCqzTC7fd3offI0TZ1P89JZgOP92cy0DThD5TRXU5D2eHOPqSLP7TiT2QJG9uAwnWLfEwRMVK4S9vbQKDEsSxvg00ZUNwy3sr',
                'Bearer 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',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      debugPrint('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (num.parse(amount)) * 100;
    return FixedNumber.getFixedNumber(a);
  }

  Future<dynamic> storePayment({
    required int orderId,
    required String status,
    required amount,
    String? transactionId,
  }) async =>
      await NGenuisPaymentService.storePayment(requestBody: <String, dynamic>{
        "order_id": orderId,
        "status": status,
        "transaction_id": transactionId,
        "amount": amount,
      });
}
