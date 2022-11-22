import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zona/generated/l10n.dart';
import 'package:zona/src/features/models/order.dart';
import 'package:zona/src/features/models/service.dart';
import 'package:zona/src/features/view/screens/ngenius_order.dart';
import 'package:zona/src/features/view/screens/pay_now_screen/pay_now_screen.dart';
import 'package:zona/src/utils/app_strings/api_path.dart';
import 'package:zona/src/utils/responsive.dart';

import '../main_app_screens/home_layout_screen/home_layout_screen.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({Key? key, required this.order, this.service}) : super(key: key);
  Order order;
  Services? service;

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var _future;

  @override
  void initState() {
    _future = getService();
    super.initState();
  }

  Services service = Services();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Pay Now",
            style: TextStyle(
                // fontFamily: "RaleWay",
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.orderDetails,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              widget.order.date.toString().substring(0, 10),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String token = prefs.getString('token').toString();
                            http.post(
                                Uri.parse(
                                    'http://new.zona.ae/api/invoice/create-pdf'),
                                body: {
                                  "token": token,
                                  "id_order": widget.order.id.toString(),
                                }).then((value) {
                              final url = jsonDecode(value.body.toString());
                              debugPrint('TSTS url: ${url['url']}');
                              launchUrl(Uri.parse(url['url']),
                                      mode: LaunchMode.externalApplication)
                                  .then((value) {})
                                  .onError((error, stackTrace) {
                                debugPrint('TSTS err launch url: $error');
                              });
                            }).onError((error, stackTrace) {
                              debugPrint('TSTS error' + error.toString());
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                S.current.viewBill,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Text(S.current.createdBy),
                    Text(
                      '' + widget.order.name.toString(),
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: _future,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Builder(builder: (context) {
                                          if (widget.service!.image
                                                  .toString() ==
                                              "null") {
                                            return Container(
                                              height: 130,
                                              width: 130,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: const Center(
                                                    child: Icon(
                                                        Icons.room_service),
                                                  )),
                                            );
                                          } else {
                                            return Container(
                                              height: 130,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        "http://new.zona.ae/" +
                                                            widget
                                                                .service!.image
                                                                .toString(),
                                                      ),
                                                      fit: BoxFit.cover)),
                                            );
                                          }
                                        }),
                                        Container(
                                          height: 130,
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color.fromRGBO(
                                                        255, 197, 84, 1),
                                                  ),
                                                  Text(
                                                    widget.service!.rate
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color.fromRGBO(
                                                          26, 29, 31, 1),
                                                    ),
                                                  ),
                                                  // const Text(
                                                  //   " (0)",
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,
                                                  //     fontWeight: FontWeight.w700,
                                                  //     color: Color.fromRGBO(
                                                  //         111, 118, 126, 1),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 150,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.service!.name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            154, 159, 165, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      widget.service!.address
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            154, 159, 165, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const Divider(),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            S.current.time,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Builder(builder: (context) {
                            return Text(
                              widget.order.time.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            S.current.status,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Builder(builder: (context) {
                            print(widget.order.status);
                            if (widget.order.status.toString() == "0") {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.current.pending,
                                          style: const TextStyle(
                                              fontFamily: 'Schyler',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const Icon(
                                          Icons.pending,
                                          color: Colors.white,
                                        )
                                      ],
                                    )),
                              );
                            } else if (widget.order.status.toString() == "1") {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.current.inWay,
                                          style: const TextStyle(
                                              fontFamily: 'Schyler',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const Icon(
                                          Icons.arrow_right_alt,
                                          color: Colors.white,
                                        )
                                      ],
                                    )),
                              );
                            } else {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.current.delivered,
                                          style: const TextStyle(
                                              fontFamily: 'Schyler',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      ],
                                    )),
                              );
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            S.current.phone,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            widget.order.phone.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            S.current.price,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            widget.order.totalPrice.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            S.current.location,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse(
                                  'https://maps.google.com/?q=' +
                                      widget.order.latitude.toString() +
                                      ',' +
                                      widget.order.longitude.toString() +
                                      ''));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        S.current.openMap,
                                        style: const TextStyle(
                                            fontFamily: 'Schyler',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      const Icon(
                                        Icons.launch,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    Text(
                      S.current.notes,
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.order.notes.toString(),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: Responsive.getScreenWidth(context) * 0.3,
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return FormPay(
                            order: widget.order,
                            callBack: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, HomeScreen.id, (route) => false);
                            },
                          );
                        }),
                      );
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          S.current.payNow,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    http.post(Uri.parse('http://new.zona.ae/api/auth/one_service'), body: {
      "token": token,
      "id": widget.order.idservice.toString()
    }).then((value) {
      setState(() {
        service = Services.fromJson(jsonDecode(value.body)[0]);
      });
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }
}
