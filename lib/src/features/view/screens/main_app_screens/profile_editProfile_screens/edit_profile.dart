import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zona/src/features/models/user.dart';
import 'package:zona/generated/l10n.dart';

import '../../../../../providers/home_provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key, required this.user}) : super(key: key);
  final MyUser user;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController lastName = TextEditingController();
  String? image;

  String gender = S.current.mr;

  @override
  void initState() {
    phoneNumber.text = widget.user.phone.toString();
    firstName.text = widget.user.firstName.toString();
    lastName.text = widget.user.lastName.toString();
    image = widget.user.profileImage.toString();
    if (widget.user.gender.toString().toLowerCase() == 'male') {
      gender = S.current.mr;
    } else {
      gender = S.current.mrs;
    }
    genderValueLocalized = gender;

    // TODO: implement initState
    super.initState();
  }

  bool loading = false;
  GlobalKey<FormState> key = GlobalKey();
  String? genderValueLocalized;

  checkProfileImage() {
    return Uri.parse(image!).isAbsolute
        ? NetworkImage(image!)
        : FileImage(File(image!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  S.current.editProfile,
                  style: const TextStyle(
                      fontFamily: 'Schyler',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      S.current.updateYourInformation,
                      style: const TextStyle(
                        fontFamily: 'Schyler',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 22,
                ),
                InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    final XFile? img =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (img != null) {
                      image = img.path;
                      debugPrint('TSTS imagePath: $image');
                      widget.user.profileImage = img.path;
                      setState(() {});
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Builder(builder: (context) {
                      if (image.toString() == 'null') {
                        return SizedBox(
                          width: 75,
                          height: 75,
                          child: CircleAvatar(
                            child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(25)),
                              child: const Icon(
                                Icons.person,
                                color: Colors.black45,
                                size: 30,
                              ),
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 75,
                        width: 75,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: checkProfileImage(),
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    controller: firstName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        child: DropdownButton<String>(
                          value: genderValueLocalized ?? S.current.mr,
                          dropdownColor: Colors.white,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            setState(
                              () {
                                genderValueLocalized = newValue!;
                                gender = mapGenderLocalizedValue(
                                    genderValueLocalized);
                              },
                            );
                          },
                          items: <String>[
                            S.current.mr, S.current.mrs,
                            // 'Mr.',
                            // 'Mrs.'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 5),
                      fillColor: Colors.white,
                      disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff2b2a2a), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: S.current.firstName,
                      errorStyle: const TextStyle(fontFamily: 'Schyler'),
                      hintStyle: const TextStyle(
                        fontFamily: 'Schyler',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: lastName,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 20),
                            fillColor: Colors.white,
                            disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff2b2a2a), width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: S.current.lastName,
                            errorStyle: const TextStyle(fontFamily: 'Schyler'),
                            hintStyle: const TextStyle(
                              fontFamily: 'Schyler',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return S.current.pleaseAddMobileNumber;
                      } else {
                        return null;
                      }
                    },
                    controller: phoneNumber,
                    obscureText: false,
                    style: const TextStyle(
                        fontFamily: 'Schyler',
                        fontSize: 14.0,
                        height: 1.0,
                        color: Colors.black),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: CountryCodePicker(
                        initialSelection: 'AE',
                        enabled: false,
                      ),
                      contentPadding: const EdgeInsets.only(left: 20),
                      fillColor: Colors.white,
                      disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff2b2a2a), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: S.current.mobileNumber,
                      errorStyle: const TextStyle(fontFamily: 'Schyler'),
                      hintStyle: const TextStyle(
                        fontFamily: 'Schyler',
                      ),
                    ),
                  ),
                ),
                !loading
                    ? InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          // String base64Image = '';
                          // if (image != null &&
                          //     image!.isNotEmpty &&
                          //     image.toString() != 'null') {
                          //   final bytes = File(image!).readAsBytesSync();
                          //   base64Image =
                          //       "data:image/jpeg;base64," + base64Encode(bytes);
                          // }
                          MyUser user = MyUser(
                              id: widget.user.id,
                              email: widget.user.email,
                              name: '',
                              firstName: firstName.text,
                              lastName: lastName.text,
                              gender: gender == "Mr." ? 'Male' : 'Female',
                              phone: phoneNumber.text,
                              profileImage: widget.user.profileImage,
                              verified: widget.user.verified,
                              emailVerifiedAt: widget.user.emailVerifiedAt,
                              createdAt: widget.user.createdAt,
                              dateOfBirth: widget.user.dateOfBirth,
                              updatedAt: widget.user.updatedAt,
                              verificationCodes: widget.user.verificationCodes);

                          FormData formData;
                          if (image != null &&
                              image!.isNotEmpty &&
                              image.toString() != 'null' &&
                              !Uri.parse(image!).isAbsolute) {
                            String fileName = image!.split('/').last;
                            String ext = fileName.split('.').last;
                            String fileNameToSend = 'img.' + ext;

                            formData = FormData.fromMap({
                              "profile_image": await MultipartFile.fromFile(
                                  image!,
                                  filename: fileNameToSend),
                              'token': prefs.getString('token'),
                              'id': widget.user.id.toString(),
                              'first_name': firstName.text,
                              'last_name': lastName.text,
                              'phone': phoneNumber.text,
                              'gender': gender == "Mr." ? 'Male' : 'Female',
                              'date_of_birth ':
                                  widget.user.dateOfBirth.toString(),
                            });
                          } else {
                            formData = FormData.fromMap({
                              'token': prefs.getString('token'),
                              'id': widget.user.id.toString(),
                              'first_name': firstName.text,
                              'last_name': lastName.text,
                              'phone': phoneNumber.text,
                              'gender': gender == "Mr." ? 'Male' : 'Female',
                              'date_of_birth ':
                                  widget.user.dateOfBirth.toString(),
                            });
                          }

                          prefs
                              .setString('user', jsonEncode(user))
                              .then((value) async {
                            try {
                              await Dio()
                                  .post(
                                      'http://new.zona.ae/api/auth/update_user_data',
                                      options: Options(
                                          contentType:
                                              Headers.formUrlEncodedContentType,
                                          headers: {
                                            'Accept': 'application/json'
                                          }),
                                      data: formData)
                                  .then((value) async {
                                debugPrint('TSTS code: ${value.statusCode}');
                                debugPrint('TSTS body: ${value.data}');
                                debugPrint(
                                    'TSTS message: ${value.statusMessage}');
                                if (value.statusCode == 200) {
                                  HomeProvider homeProvider =
                                      Provider.of<HomeProvider>(context,
                                          listen: false);
                                  homeProvider.setProfileUpdated(true);
                                  Navigator.pop(context);
                                }
                              });
                            } on DioError catch (e) {
                              Navigator.pop(context);
                              debugPrint(
                                  'TSTS error: ' + e.response.toString());
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(26, 27, 45, 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  S.current.save,
                                  style: const TextStyle(
                                      fontFamily: 'Schyler',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }

  String mapGenderLocalizedValue(String? genderValueLocalized) {
    if (genderValueLocalized == "سيد" || genderValueLocalized == "Mr.") {
      return "Mr.";
    }
    return "Mrs.";
  }
}
