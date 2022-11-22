// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:zona/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zona/src/core/progress_dialog.dart';
import 'package:zona/src/features/models/serviceprovider.dart';
import 'package:zona/src/features/models/service.dart';
import 'package:zona/src/features/view/screens/ServiceDetailsScreen.dart';
import 'package:zona/src/features/view/screens/provider_services.dart';
import '../../models/category.dart';
import '../../../config/routing.dart';
import '../../../utils/text_input_decoration.dart';

class ProviderServices extends StatefulWidget {
  ProviderServices(
      {Key? key, required this.provider, required this.categoryName})
      : super(key: key);

  static String id = "providers-services";

  final ServiceProvider provider;
  String categoryName;

  @override
  State<ProviderServices> createState() => _ProviderServicesState();
}

class _ProviderServicesState extends State<ProviderServices> {
  final TextEditingController _phoneController = TextEditingController();
  bool isLoading = true;

  setLoading(bool val) {
    isLoading = val;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getToken();
    getServices();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    // print("faf");
    if (kDebugMode) {
      print("ProviderID " + widget.provider.id.toString());
      print("Token " + token);
    }
  }

  List<Services> services = [];
  String name = '';

  @override
  Widget build(BuildContext context) {
    getToken();
    return MyProgressDialog(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Color.fromRGBO(26, 27, 45, 1),
          backgroundColor: Colors.white,
          elevation: 0,
          title: TextField(
            obscureText: false,
            keyboardType: TextInputType.text,
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
            decoration: kTextFieldDecoration.copyWith(
                suffixIcon: Icon(
                  Icons.search_rounded,
                  color: Color.fromRGBO(26, 27, 45, 1),
                ),
                hintText: S.current.searchByNamePrice,
                hintStyle: TextStyle()),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              height: 900,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            S.current.i,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(202, 189, 255, 1),
                            ),
                          ),
                          Text(
                            "  " +
                                (widget.provider.firstName.toString() +
                                    " " +
                                    widget.provider.lastName.toString()) +
                                ' Services',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(26, 29, 31, 1),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  servicesList(),
                ],
              )),
        ),
      ),
    );
  }

  servicesList() {
    return Expanded(
        child: ListView.builder(
      itemCount: services.length,
      itemBuilder: (BuildContext context, int index) {
        if (services.isEmpty) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          if (services
                  .elementAt(index)
                  .name
                  .toString()
                  .toLowerCase()
                  .contains(name.toLowerCase()) ||
              services
                  .elementAt(index)
                  .price
                  .toString()
                  .toLowerCase()
                  .contains(name.toLowerCase())) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(Routing().createRoute(ServiceDetailsScreen(
                      service: services.elementAt(index),
                      categoryName: widget.categoryName,
                      provider: widget.provider,
                    )));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          imgWidget(index),
                          Container(
                            height: 130,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rateWidget(index),
                                nameWidget(index),
                                startFromWidget(index),
                                priceBookingWidget(index),
                              ],
                            ),
                          )
                        ],
                      ),
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 10, top: 10),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.workspaces),
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 2,
                )
              ],
            );
          } else {
            return Container();
          }
        }
        // if (services.elementAt(index).idcategory.toString() ==
        //     widget.provider.id.toString()) {
        // if (services.isEmpty) {
        //           return Center(
        //             child: CircularProgressIndicator.adaptive(),
        //           );
        //         } else {
        //           if (services
        //               .elementAt(index)
        //               .name
        //               .toString()
        //               .toLowerCase()
        //               .contains(name.toLowerCase()) ||
        //               services
        //                   .elementAt(index)
        //                   .price
        //                   .toString()
        //                   .toLowerCase()
        //                   .contains(name.toLowerCase())) {
        //             return Column(
        //               children: [
        //                 InkWell(
        //                   onTap: () {
        //                     Navigator.of(context)
        //                         .push(Routing().createRoute(ServiceDetailsScreen(
        //                       service: services.elementAt(index),
        //                       categoryName: widget.categoryName,
        //                       provider: widget.provider,
        //                     )));
        //                   },
        //                   child: Row(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Row(
        //                         children: [
        //                           imgWidget(index),
        //                           Container(
        //                             height: 130,
        //                             padding: EdgeInsets.all(10),
        //                             child: Column(
        //                               mainAxisAlignment:
        //                               MainAxisAlignment.spaceEvenly,
        //                               crossAxisAlignment: CrossAxisAlignment.start,
        //                               children: [
        //                                 rateWidget(index),
        //                                 nameWidget(index),
        //                                 startFromWidget(index),
        //                                 priceBookingWidget(index),
        //                               ],
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                       Flexible(
        //                           child: Padding(
        //                             padding: const EdgeInsets.only(right: 10, top: 10),
        //                             child: IconButton(
        //                               onPressed: () {},
        //                               icon: Icon(Icons.workspaces),
        //                             ),
        //                           ))
        //                     ],
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 20,
        //                 ),
        //                 Divider(
        //                   thickness: 2,
        //                 )
        //               ],
        //             );
        //           } else {
        //             return Container();
        //           }
        //         }
        // } else {
        //   return Container();
        // }
      },
    ));
  }

  imgWidget(int index) {
    return Container(
      height: 130,
      width: 130,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          'http://new.zona.ae/public${services.elementAt(index).image}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  priceBookingWidget(int index) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 25,
          child: RawMaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            fillColor: Color.fromRGBO(181, 228, 202, 1),
            onPressed: null,
            child: Text(
              S.current.aED + ' ' + services.elementAt(index).price.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(26, 29, 31, 1),
              ),
            ),
          ),
        ),
        SizedBox(width: 6),
        Container(
          width: 60,
          height: 25,
          child: RawMaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            fillColor: Color.fromRGBO(202, 189, 255, 1),
            onPressed: null,
            child: Text(
              S.current.booking,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(26, 29, 31, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  rateWidget(int index) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 20,
          color: Color.fromRGBO(255, 197, 84, 1),
        ),
        SizedBox(width: 2),
        Text(
          services.elementAt(index).rate.toString(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(26, 29, 31, 1),
          ),
        ),
        Text(
          " (" + services[index].totalRatings.toString() + ")",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(111, 118, 126, 1),
          ),
        ),
      ],
    );
  }

  nameWidget(int index) {
    return Text(
      services.elementAt(index).name.toString().length > 14
          ? services.elementAt(index).name.toString().substring(0, 12) + '..'
          : services.elementAt(index).name.toString(),
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(26, 29, 31, 1),
      ),
    );
  }

  startFromWidget(int index) {
    return Text(
      S.current.startsFrom,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(154, 159, 165, 1),
      ),
    );
  }

  Future<List<Services>> getServices() async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    http.post(Uri.parse('http://new.zona.ae/api/auth/provider_services'),
        body: {
          "token": token,
          "idprovider": widget.provider.id.toString(),
          // "remove":"0",
          "status": "0"
        }).then((value) {
      setLoading(false);
      setState(() {
        var data = jsonDecode(value.body);
        Iterable l = data['data'];
        debugPrint('TSTS getServices: $l');
        services = List<Services>.from(l.map((model) {
          Services item = Services.fromJson(model);
          return item;
        }));
      });
    }).onError((error, stackTrace) {
      debugPrint('TSTS $error');
      setLoading(false);
      services = [];
      print(services);
    });
    return services;
  }
}
