import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zona/src/core/progress_dialog.dart';
import 'package:zona/src/features/models/serviceprovider.dart';
import 'package:zona/src/features/view/screens/provider_services.dart';
import 'package:zona/generated/l10n.dart';
import 'package:zona/src/utils/responsive.dart';
import '../../../config/routing.dart';
import '../../../utils/text_input_decoration.dart';

class CategoryProviders extends StatefulWidget {
  String? idCategory;
  String? categoryName;
  bool dashboardView;

  CategoryProviders(
      {this.idCategory, this.categoryName, required this.dashboardView});

  @override
  State<CategoryProviders> createState() => _CategoryProvidersState();
}

class _CategoryProvidersState extends State<CategoryProviders> {
  final TextEditingController _phoneController = TextEditingController();
  bool isLoading = true;

  setLoading(bool val) {
    isLoading = val;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProviders();
  }

  List<ServiceProvider> providers = [];
  String name = '';

  final String? baseURL = "http://new.zona.ae";

  @override
  Widget build(BuildContext context) {
    return !widget.dashboardView
        ? MyProgressDialog(
            inAsyncCall: isLoading,
            child: Scaffold(
              appBar: AppBar(
                foregroundColor: const Color.fromRGBO(26, 27, 45, 1),
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
                      suffixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color.fromRGBO(26, 27, 45, 1),
                      ),
                      hintText: S.current.searchByNameLocation,
                      hintStyle: const TextStyle()),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(12),
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
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(202, 189, 255, 1),
                                ),
                              ),
                              Text(
                                "  " + widget.categoryName! + ' Providers',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(26, 29, 31, 1),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      providerList(),
                    ],
                  ),
                ),
              ),
            ),
          )
        : providerList();
  }

  providerList() {
    return SizedBox(
      height: 210,
      width: Responsive.getScreenWidth(context),
      child: ListView.builder(
        scrollDirection: widget.dashboardView ? Axis.horizontal : Axis.vertical,
        itemCount: providers.length,
        itemBuilder: (BuildContext context, int index) {
          if (providers.elementAt(index).idcategory.toString() ==
              widget.idCategory) {
            if (providers.isEmpty) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              if (providers
                      .elementAt(index)
                      .firstName
                      .toString()
                      .toLowerCase()
                      .contains(name.toLowerCase()) ||
                  providers
                      .elementAt(index)
                      .location
                      .toString()
                      .toLowerCase()
                      .contains(name.toLowerCase())) {
                return item(index);
              } else {
                return Container();
              }
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  item(int index) {
    return !widget.dashboardView
        ? Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(Routing().createRoute(ProviderServices(
                    provider: providers.elementAt(index),
                    categoryName: widget.categoryName!,
                  )));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        imgWidget(index),
                        Container(
                          height: 130,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // rateWidget(index),
                              nameWidget(index),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: const Color.fromRGBO(41, 48, 60, 1),
                          onPressed: () {
                            launchUrl(Uri.parse('tel:' +
                                providers.elementAt(index).phone.toString()));
                          },
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 2,
              )
            ],
          )
        : SizedBox(
            width: 180,
            height: 200,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(Routing().createRoute(ProviderServices(
                          provider: providers.elementAt(index),
                          categoryName: widget.categoryName!,
                        )));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          imgWidget(index),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // height: 130,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // rateWidget(index),
                                      nameWidget(index),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: RawMaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor:
                                          const Color.fromRGBO(41, 48, 60, 1),
                                      onPressed: () {
                                        launchUrl(Uri.parse('tel:' +
                                            providers
                                                .elementAt(index)
                                                .phone
                                                .toString()));
                                      },
                                      child: const Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  imgWidget(int index) {
    return Container(
      height: 100,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          providers.elementAt(index).profileImage!.contains('http')
              ? providers.elementAt(index).profileImage!
              : baseURL! + providers.elementAt(index).profileImage.toString(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // rateWidget(int index) {
  //   return Row(
  //     children: [
  //       Icon(
  //         Icons.star,
  //         size: 20,
  //         color: Color.fromRGBO(255, 197, 84, 1),
  //       ),
  //       SizedBox(width: 2),
  //       Text(
  //         '0',
  //         style: TextStyle(
  //           fontSize: 12,
  //           fontWeight: FontWeight.w700,
  //           color: Color.fromRGBO(26, 29, 31, 1),
  //         ),
  //       ),
  //       Text(
  //         " (0)",
  //         style: TextStyle(
  //           fontSize: 12,
  //           fontWeight: FontWeight.w700,
  //           color: Color.fromRGBO(111, 118, 126, 1),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  nameWidget(int index) {
    return Text(
      (providers.elementAt(index).firstName.toString() +
                      " " +
                      providers.elementAt(index).lastName.toString())
                  .length >
              15
          ? (providers.elementAt(index).firstName.toString() +
                      " " +
                      providers.elementAt(index).lastName.toString())
                  .substring(0, 10) +
              ".."
          : (providers.elementAt(index).firstName.toString() +
              " " +
              providers.elementAt(index).lastName.toString()),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(26, 29, 31, 1),
      ),
    );
  }

  Future<List<ServiceProvider>> getProviders() async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    http.post(Uri.parse('http://new.zona.ae/api/auth/provider_by_idcategory'),
        body: {"token": token, "idcategory": widget.idCategory}).then((value) {
      setState(() {
        setLoading(false);
        var data = jsonDecode(value.body);
        Iterable l = data['data'];
        debugPrint('TSTS list: $l');
        providers =
            List<ServiceProvider>.from(l.map((model) => ServiceProvider.fromJson(model)));
      });
    }).onError((error, stackTrace) {
      setLoading(false);
      print(error.toString());
    });
    return providers;
  }
}
