import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/components/custom_listtile.dart';
import 'package:task_manger/presentation_layer/components/custom_text_field.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/screen/auth/info_account_screen/info_account_screen.dart';
import 'package:task_manger/presentation_layer/screen/auth/info_account_screen/widget/EditImage.dart';
import 'package:task_manger/presentation_layer/screen/auth/info_account_screen/widget/custom_phone_number.dart';
import 'package:task_manger/presentation_layer/screen/profile_screen/profile_screen.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool isLoading = false;
  String name = sharedPreferences.getString('name')!;
  String code = sharedPreferences.getString('code') ?? 'EG';
  String number = sharedPreferences.getString('phone')!;
  String email = sharedPreferences.getString('email')!;
  @override
  void initState() {
    print('image : ${sharedPreferences.getString('image')}  code : $code');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Edit Profile'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _handleAttachmentPressed();
                    },
                    child: EditImage(
                      image: sharedPreferences.getString('image') == null ||
                              sharedPreferences.getString('image')!.isEmpty ||
                              sharedPreferences.getString('image') == ''
                          ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                          : sharedPreferences.getString('image')!,
                    ),
                  ),
                  // EditImage(),
                  SizedBox(height: 30),
                  // SizedBox(height: deviceInfo.localHeight * 0.1),
                  CustomTextfield(
                    inialvalue: name,
                    valid: (p0) {},
                    onsaved: (p0) {},
                    onChanged: (p0) {
                      name = p0.toString();
                    },
                    titel: 'Full Name',
                    width: deviceInfo.localWidth * 0.85,
                    height: 60,
                  ),
                  // SizedBox(height: 20),
                  // CustomTextfield(
                  //   inialvalue: 'Christina',
                  //   valid: (p0) {},
                  //   onsaved: (p0) {},
                  //   titel: 'Full Name',
                  //   width: deviceInfo.localWidth * 0.85,
                  //   height: 60,
                  // ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    inialvalue: sharedPreferences.getString('email'),
                    valid: (p0) {},
                    onsaved: (p0) {},
                    titel: 'Full Email',
                    width: deviceInfo.localWidth * 0.85,
                    height: 60,
                    onChanged: (p0) {
                      email = p0.toString();
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: deviceInfo.localWidth * 0.85,
                    child: IntlPhoneField(
                      initialValue: number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1.2,
                            // style: BorderStyle.none,
                            color: ColorManager.kPrimary,
                          ), //<-- SEE HERE
                        ),

                        //  enabled: true,
                        filled: true,
                        fillColor: ColorManager.fillColor,
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 14,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                          letterSpacing: 0.20,
                        ),
                      ),
                      initialCountryCode: code,
                      onChanged: (phone) {
                        number = phone.completeNumber;
                        code = phone.countryISOCode;
                        print(phone.countryISOCode);
                        print(phone.completeNumber);
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    boxShadowValue: BoxShadow(),
                    width: deviceInfo.localWidth * 0.85,
                    rectangel: 18,
                    haigh: 60,
                    color: ColorManager.kPrimary,
                    text: "Update",
                    colorText: Colors.white,
                    press: () async {
                      final userDoc = FirebaseFirestore.instance
                          .collection('users')
                          .doc(sharedPreferences.getString('id'));
                      await userDoc.update({
                        'name': name,
                        'code': code,
                        'phone': number,
                      });
                      sharedPreferences.setString(
                        'name',
                        name,
                      );
                      sharedPreferences.setString(
                        'phone',
                        number,
                      );
                      sharedPreferences.setString(
                        'email',
                        email,
                      );
                      sharedPreferences.setString(
                        'code',
                        code,
                      );
                      showToast('The data has been updated successfully.');
                      Get.off(() => ProfileScreen());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future getImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 50, // reduce image quality to 50%
      maxWidth: 400, // reduce image width to 400 pixels
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      uploadImageFiles(imageFile);
    }
  }

  Future<UploadTask> uploadImageFile(File image, String filename) async {
    Reference reference = await FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);

    return uploadTask;
  }

  void uploadImageFiles(File imageFile) async {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences.getString('id'));
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = await uploadImageFile(imageFile, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      await userDoc.update({
        'image': imageUrl,
      });
      sharedPreferences.setString('image', imageUrl);
      setState(() {
        isLoading = false;
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.message.toString());
    }
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: ColorManager.background,
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomListtile(
              onTap: () {
                Navigator.pop(context);
                getImage(ImageSource.camera);
              },
              titel: 'photo shoot',
              widget: Icon(Icons.camera),
              // color: ColorManager.background,
            ),
            CustomListtile(
              onTap: () {
                Navigator.pop(context);
                getImage(ImageSource.gallery);
              },
              titel: 'select a picture',
              widget: Icon(Icons.photo_album),
              // color: ColorManager.background,
            ),
            CustomListtile(
              onTap: () {
                Navigator.pop(context);
              },
              titel: 'Close',
              // color: ColorManager.background,
              widget: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
