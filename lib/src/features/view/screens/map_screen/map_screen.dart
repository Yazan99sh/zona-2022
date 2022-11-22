// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../generated/l10n.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key, required this.long, required this.lat})
      : super(key: key);

  static String id = "map";

  double long;
  double lat;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  bool checked = false;
  double lat = 0.0;
  double long = 0.0;
  List<Marker> myMarker = <Marker>[];
  @override
  void initState() {
    // _googleMapController = GoogleMapController(GoogleMapController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: GoogleMap(
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(myMarker),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.lat, widget.long),
                    zoom: 10.0,
                  ),
                  onMapCreated: (controller) {
                    _googleMapController = controller;
                  },
                  onTap: _handleTap,
                )),
            Positioned(
              height: 240,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: 400,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            S.current.selectLocation,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(30, 30, 30, 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20,
                          ),
                          child: Divider(
                            thickness: 2,
                            color: Color.fromRGBO(235, 235, 235, 1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(157, 157, 157, 1),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Expanded(
                        //         child: Container(
                        //           padding: EdgeInsets.all(10),
                        //           height: 50,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(8),
                        //             color: Color.fromRGBO(245, 245, 245, 1),
                        //           ),
                        //           child: Row(
                        //             children: [
                        //               Container(
                        //                 height: 30,
                        //                 width: 30,
                        //                 decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(20),
                        //                     color:
                        //                         Color.fromRGBO(202, 189, 255, 1)),
                        //                 child: Icon(
                        //                   Icons.home,
                        //                   color: Colors.black,
                        //                   size: 22,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "   Home",
                        //                 style: TextStyle(
                        //                     color: Colors
                        //                         .black, //Color.fromRGBO(41, 48, 60, 1),
                        //                     fontSize: 15,
                        //                     fontWeight: FontWeight.w500),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       Expanded(
                        //         child: Container(
                        //           padding: EdgeInsets.all(10),
                        //           height: 50,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(8),
                        //             color: Color.fromRGBO(245, 245, 245, 1),
                        //           ),
                        //           child: Row(
                        //             children: [
                        //               Container(
                        //                 height: 30,
                        //                 width: 30,
                        //                 decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(20),
                        //                     color:
                        //                         Color.fromRGBO(202, 189, 255, 1)),
                        //                 child: Icon(
                        //                   Icons.work,
                        //                   color: Colors.black,
                        //                   size: 22,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "   Office",
                        //                 style: TextStyle(
                        //                     color: Colors
                        //                         .black, //Color.fromRGBO(41, 48, 60, 1),
                        //                     fontSize: 15,
                        //                     fontWeight: FontWeight.w500),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: SizedBox(
                            height: 60,
                            child: RawMaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              fillColor: Colors.black,
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                Map<String, double> data = {
                                  "long": long,
                                  "lat": lat
                                };
                                prefs.setString("address", jsonEncode(data));
                                Navigator.pop(context);
                              },
                              child: Text(
                                S.current.saveAddress,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(LatLng tappedPosition) async {
    setState(() {
      lat = tappedPosition.latitude;
      long = tappedPosition.longitude;
      checked = true;
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPosition.toString()),
        position: tappedPosition,
      ));
    });
  }
}
