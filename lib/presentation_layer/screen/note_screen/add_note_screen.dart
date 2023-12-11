import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import '../../../main.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  double fontSize = 20; // Initial font size
  double textOpacity = 1.0; // Initial text opacity
  String title = '';
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: InfoWidget(
          builder: (context, deviceInfo) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          Get.off(() => MainScreen());
                        },
                      ),
                      Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (fontSize >= 90) {
                              fontSize = 20;
                            }
                            fontSize += 5;
                          });
                          print(fontSize);
                        },
                        icon: Image.asset(
                          "assets/icons/aa.png",
                          width: 25,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (textOpacity <= 0.1) {
                              textOpacity = 1.0;
                            }
                            textOpacity -= 0.1;
                          });
                        },
                        icon: Image.asset(
                          "assets/icons/a.png",
                          width: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      autocorrect: false,
                      enableSuggestions: false,
                      maxLines: 1,
                      onChanged: (p0) {
                        title = p0.toString();
                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        helperText: "Title",
                        hintStyle: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 17,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                          letterSpacing: 0.20,
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: textOpacity,
                    child: TextFormField(
                      autocorrect: false,
                      enableSuggestions: false,
                      maxLines: null,
                      onChanged: (p0) {
                        message = p0.toString();
                      },
                      style: TextStyle(fontSize: fontSize),
                      decoration: InputDecoration(
                        helperText: "Content",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                          letterSpacing: 0.20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomButton(
                      width: deviceInfo.localWidth * 0.9,
                      haigh: 55,
                      color: ColorManager.kPrimary,
                      text: "save",
                      press: () async {
                        if (message.isEmpty || title.isEmpty) {
                          showToast('There are some empty fields');
                        } else {
                          DateTime now = DateTime.now();
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(sharedPreferences.getString('id'))
                              .collection('notes')
                              .doc(now.millisecondsSinceEpoch.toString())
                              .set({
                            'title': title,
                            'pass': "",
                            'note': message,
                            'star': false,
                            'id': now.millisecondsSinceEpoch.toString(),
                          });
                          Get.off(() => MainScreen());
                          showToast('Note added successfully');
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
