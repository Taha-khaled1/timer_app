import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:task_manger/application_layer/utils/valid.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/components/custom_text_field.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class InfoAccount extends StatefulWidget {
  const InfoAccount({Key? key, required this.isgoogle}) : super(key: key);
  final bool isgoogle;
  @override
  State<InfoAccount> createState() => _InfoAccountState();
}

class _InfoAccountState extends State<InfoAccount> {
  final GlobalKey<FormState> formkeysigin = GlobalKey();
  bool isLoading = false;
  String? name = '';
  String? email = '';
  String? number = '';
  String? code = 'US';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  'Fill Your Profile',
                  style: MangeStyles().getBoldStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: FontSize.s30 + 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Don\'t worry, you can always change it later, or you can skip it for now.',
                  style: MangeStyles().getRegularStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: FontSize.s18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                SizedBox(height: 30),
                Form(
                  key: formkeysigin,
                  child: Column(
                    children: [
                      CustomTextfield(
                        valid: (value) {
                          return validInput(value.toString(), 3, 100, 'name');
                        },
                        onsaved: (value) {
                          return name = value.toString();
                        },
                        titel: 'Full Name',
                        width: deviceInfo.localWidth * 0.8,
                        height: 60,
                      ),
                      SizedBox(height: 15),
                      CustomTextfield(
                        valid: (value) {
                          return validInput(value.toString(), 3, 100, 'name');
                        },
                        onsaved: (value) {
                          return null;
                        },
                        titel: 'Nickname',
                        width: deviceInfo.localWidth * 0.8,
                        height: 60,
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: deviceInfo.localWidth * 0.8,
                        child: IntlPhoneField(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onSaved: (newValue) {
                            number = newValue!.number.toString();
                          },
                          validator: (value) {
                            return validInput(
                              value!.number.toString(),
                              6,
                              100,
                              'number',
                            );
                          },
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
                            fillColor: Theme.of(context).colorScheme.surface,
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
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
                            print(phone.completeNumber);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      boxShadowValue: BoxShadow(),
                      width: deviceInfo.localWidth * 0.42,
                      rectangel: 18,
                      haigh: 60,
                      color: Color(0xffFFEEEF),
                      text: "Skip",
                      colorText: Colors.black,
                      press: () {
                        if (widget.isgoogle) {
                          print("hi");
                          sharedPreferences.setString(
                            'code',
                            code ?? 'US',
                          );
                          sharedPreferences.setString(
                            'phone',
                            number ?? '00000',
                          );
                          sharedPreferences.setString("lev", '2');
                          Get.offAll(() => MainScreen());
                        } else {
                          showToast(
                            "You must fill in the data for a better experience",
                          );
                        }
                      },
                    ),
                    CustomButton(
                      width: deviceInfo.localWidth * 0.42,
                      rectangel: 18,
                      haigh: 60,
                      color: ColorManager.kPrimaryButton,
                      text: "Start",
                      press: () async {
                        try {
                          final userDoc = FirebaseFirestore.instance
                              .collection('users')
                              .doc(sharedPreferences.getString('id'));

                          if (formkeysigin.currentState!.validate()) {
                            formkeysigin.currentState!.save();

                            await userDoc.set({
                              'name':
                                  name ?? sharedPreferences.getString('name'),
                              'userId': sharedPreferences.getString('id'),
                              'image': sharedPreferences.getString('image'),
                              'phone': number,
                              'code': code,
                            });

                            sharedPreferences.setString(
                              'name',
                              name ?? "",
                            );
                            sharedPreferences.setString(
                              'code',
                              code ?? '',
                            );
                            sharedPreferences.setString(
                              'phone',
                              number ?? '',
                            );
                            sharedPreferences.setString("lev", '2');
                            Get.to(() => MainScreen());
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Future getImage(ImageSource source) async {
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? pickedFile;
  //   pickedFile = await imagePicker.pickImage(
  //     source: source,
  //     imageQuality: 50, // reduce image quality to 50%
  //     maxWidth: 400, // reduce image width to 400 pixels
  //   );
  //   if (pickedFile != null) {
  //     File imageFile = File(pickedFile.path);
  //     uploadImageFiles(imageFile);
  //   }
  // }

  // Future<UploadTask> uploadImageFile(File image, String filename) async {
  //   Reference reference = await FirebaseStorage.instance.ref().child(filename);
  //   UploadTask uploadTask = reference.putFile(image);

  //   return uploadTask;
  // }

  // void uploadImageFiles(File imageFile) async {
  //   final userDoc = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(sharedPreferences.getString('id'));
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   UploadTask uploadTask = await uploadImageFile(imageFile, fileName);
  //   try {
  //     TaskSnapshot snapshot = await uploadTask;
  //     String imageUrl = await snapshot.ref.getDownloadURL();
  //     await userDoc.update({
  //       'image': imageUrl,
  //     });
  //     sharedPreferences.setString('image', imageUrl);
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } on FirebaseException catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print(e.message.toString());
  //   }
  // }

  // void _handleAttachmentPressed() {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     backgroundColor:Theme.of(context).colorScheme.background,
  //     builder: (BuildContext context) => Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(20),
  //         ),
  //       ),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           CustomListtile(
  //             onTap: () {
  //               Navigator.pop(context);
  //               getImage(ImageSource.camera);
  //             },
  //             titel: 'التقاط صوره',
  //             widget: Icon(Icons.camera),
  //             color: ColorManager.background,
  //           ),
  //           CustomListtile(
  //             onTap: () {
  //               Navigator.pop(context);
  //               getImage(ImageSource.gallery);
  //             },
  //             titel: 'اختار صوره',
  //             widget: Icon(Icons.photo_album),
  //             color: ColorManager.background,
  //           ),
  //           CustomListtile(
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //             titel: 'اغلاق',
  //             color: ColorManager.background,
  //             widget: Icon(
  //               Icons.cancel,
  //               color: Colors.red,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
