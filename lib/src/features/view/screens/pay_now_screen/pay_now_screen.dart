import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:zona/src/features/models/order.dart';

import '../../../../../generated/l10n.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/responsive.dart';
import '../../../../utils/text_input_decoration.dart';
import '../../../controller/stripe_controller.dart';
import '../../components/components.dart';
import 'package:http/http.dart' as http;

class FormPay extends StatefulWidget {
  final Order order;
  final Function() callBack;

  const FormPay({Key? key, required this.order, required this.callBack})
      : super(key: key);

  @override
  _FormPayState createState() => _FormPayState();
}

class _FormPayState extends State<FormPay> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController line1Controller = TextEditingController();
  final TextEditingController line2Controller = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    userNameController.dispose();
    countryController.dispose();
    cityController.dispose();
    line1Controller.dispose();
    line2Controller.dispose();
    stateController.dispose();
    postalCodController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    final isValid = key.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();
    if (isValid) {
      key.currentState?.save();
      // _submitLogin(emailController.text().trim(), _password.trim(),/* _isLogin, */context);
    }
  }

  String email = "";
  String phone = "";
  String userName = "";
  String country = "";
  String city = "";
  String line1 = "";
  String line2 = "";
  String state = "";
  String postalCode = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.getScreenWidth(context) * 0.03,
              ),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    // Card()
                    const Text(
                      "Order  Information",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      "Personal Info",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.current.pleaseEnterEmail;
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: S.current.email,
                        )),
                    const SizedBox(height: 20.0),
                    TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: S.current.phoneNumber,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.current.phoneNumber;
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(height: 20.0),
                    TextFormField(
                        controller: userNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.current.userName;
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: S.current.userName,
                        )),
                    const SizedBox(height: 30.0 //50
                        ),
                    Text(
                      S.current.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        controller: countryController,
                        keyboardType: TextInputType.text,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "country",
                        )),
                    const SizedBox(height: 20.0 //50
                        ),
                    TextFormField(
                        controller: cityController,
                        keyboardType: TextInputType.text,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "city",
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // TextFormField(
                    //     controller: line1Controller,
                    //     keyboardType: TextInputType.text,
                    //     decoration: kTextFieldDecoration.copyWith(
                    //       hintText: "line1",
                    //     )),
                    // const SizedBox(
                    //   height: 20.0,
                    // ),
                    // TextFormField(
                    //     controller: line2Controller,
                    //     keyboardType: TextInputType.text,
                    //     decoration: kTextFieldDecoration.copyWith(
                    //       hintText: "line2",
                    //     )),
                    // const SizedBox(height: 20.0 //50
                    // ),
                    TextFormField(
                        controller: stateController,
                        keyboardType: TextInputType.text,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "state",
                        )),
                    const SizedBox(height: 20.0),
                    // TextFormField(
                    //     controller: postalCodController,
                    //     keyboardType: TextInputType.text,
                    //     decoration: kTextFieldDecoration.copyWith(
                    //       hintText: "postal Code",
                    //     )),
                    // const SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      width: double.infinity,
                      color: Colors.white,
                      child: !loading
                          ? Components.defaultPrimaryButton(
                              text: S.current.payNow,
                              press: () {
                                print(widget.order.totalPrice);
                                loading = true;
                                setState(() {});
                                if (key.currentState!.validate()) {
                                  controller.makePayment(
                                    stopLoadingCallBack: () {
                                      loading = false;
                                      setState(() {});
                                    },
                                    callBack: () {
                                      widget.callBack();
                                    },
                                    amount: widget.order.totalPrice.toString(),
                                    currency: 'aed',
                                    order: widget.order,
                                    billingDetails: BillingDetails(
                                      name: userNameController.text.trim(),
                                      email: emailController.text.trim(),
                                      phone: phoneController.text.trim(),
                                      address: Address(
                                        city: cityController.text.trim(),
                                        country: countryController.text.trim(),
                                        line1: line1Controller.text.trim(),
                                        line2: line2Controller.text.trim(),
                                        state: stateController.text,
                                        postalCode: phoneController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                              color: AppColors.mainColor,
                              context: context)
                          : const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
