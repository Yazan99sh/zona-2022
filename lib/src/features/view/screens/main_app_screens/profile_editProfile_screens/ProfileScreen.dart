import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zona/src/core/progress_dialog.dart';
import 'package:zona/src/features/models/user.dart';
import 'package:zona/generated/l10n.dart';
import 'package:zona/src/utils/colors.dart';
import 'package:zona/src/utils/responsive.dart';

import '../../../../../providers/home_provider.dart';
import '../../../../../providers/logout_provider.dart';

class ProfileScreen extends StatefulWidget {
  bool isGuest;
  ProfileScreen({Key? key, required this.isGuest}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  MyUser user = MyUser();
  Future? future;
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    if (!widget.isGuest) {
      future = getUser();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        homeProvider.addListener(() {
          if (homeProvider.profileUpdated) {
            future = getUser();
            homeProvider.setProfileUpdated(false);
          }
        });
      });
    }
  }

  checkProfileImage() {
    return Uri.parse(user.profileImage.toString()).isAbsolute
        ? NetworkImage(user.profileImage.toString())
        : FileImage(File(user.profileImage.toString()));
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return ChangeNotifierProvider.value(
      value: homeProvider,
      child: Scaffold(
        body: !widget.isGuest
            ? FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting) {
                    return Container(
                      color: const Color(0xF9F9F9FF),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: double.infinity,
                      height: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Builder(builder: (context) {
                                      if (user.profileImage.toString() ==
                                          'null') {
                                        return Container(
                                          height: 44,
                                          width: 44,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                          child: const Icon(Icons.person),
                                        );
                                      } else {
                                        return SizedBox(
                                          width: 50,
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage:
                                                  checkProfileImage()),
                                        );
                                      }
                                    }),
                                  ),
                                  title: Builder(
                                    builder: (context) {
                                      if (user.lastName == null ||
                                          user.firstName == null) {
                                        return Text(
                                          S.current.fullName,
                                          style: const TextStyle(fontSize: 15),
                                        );
                                      } else {
                                        return Text(
                                          user.firstName.toString() == 'null' ||
                                                  user.lastName.toString() ==
                                                      'null'
                                              ? S.current.userName
                                              : user.firstName.toString() ==
                                                      user.lastName.toString()
                                                  ? user.firstName.toString()
                                                  : user.firstName.toString() +
                                                      " " +
                                                      user.lastName.toString(),
                                          style: const TextStyle(fontSize: 15),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    S.current.phoneNumber,
                                    //textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(vertical: 20.0),
                                  //   child: Container(
                                  //     padding: EdgeInsets.symmetric(vertical: 10.0),
                                  //     width: double.infinity,
                                  //     decoration: BoxDecoration(
                                  //       color: Color(0xF5F5F5FF),
                                  //       borderRadius: BorderRadius.circular(8),
                                  //     ),
                                  //     child: Text(""),
                                  //   ),
                                  // ),
                                  Container(
                                    width: double.infinity,
                                    height: 45,
                                    padding: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          245, 245, 245, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.phone.toString() == "null"
                                              ? S.current.phoneNumber
                                              : user.phone.toString(),
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    S.current.email,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 45,
                                    padding: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          245, 245, 245, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.email.toString() == "null"
                                              ? S.current.email
                                              : user.email.toString(),
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    S.current.gender,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 45,
                                    padding: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          245, 245, 245, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.gender.toString() == "null"
                                              ? S.current.gender
                                              : user.gender.toString(),
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                })
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: Responsive.getScreenWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'You\'re in Guest mode, Signin',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final provider = Provider.of<LogoutProvider>(
                                context,
                                listen: false);
                            provider.logout(context);
                          },
                          child: Container(
                            width: 250,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.mainColor,
                                border: Border.all()),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.current.signIn,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.login,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userString = prefs.getString('user').toString();
      user = MyUser.fromJson(jsonDecode(userString));
    } catch (e) {
      print(e);
    }
  }
}
