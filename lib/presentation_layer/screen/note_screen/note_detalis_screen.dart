import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/components/show_dialog.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/auth/otp_screeen/otp_screeen.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class NoteDetalis extends StatefulWidget {
  final String title, des, id;
  final String? pass;
  final bool star;
  const NoteDetalis(
      {Key? key,
      required this.title,
      required this.des,
      required this.id,
      required this.star,
      this.pass})
      : super(key: key);

  @override
  State<NoteDetalis> createState() => _NoteDetalisState();
}

class _NoteDetalisState extends State<NoteDetalis> {
  double fontSize = 20; // Initial font size
  double textOpacity = 1.0; // Initial text opacity
  late bool isEdit;
  late bool isStar;
  late String title, note;
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    isEdit = false;
    isStar = widget.star;
    title = widget.title;
    note = widget.des;
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _focusOnTextField() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      bottomNavigationBar: isEdit
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: CustomButton(
                width: 400,
                haigh: 55,
                color: ColorManager.kPrimary,
                text: "save",
                press: () async {
                  if (note.isEmpty || title.isEmpty) {
                    showToast('There are some empty fields');
                    return;
                  }
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(sharedPreferences.getString('id'))
                      .collection('notes')
                      .doc(widget.id)
                      .update({
                    'title': title,
                    'note': note,
                  });
                  showToast('The note has been successfully modified');
                  setState(() {
                    isEdit = false;
                  });
                },
              ),
            )
          : null,
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
                      IconButton(
                          onPressed: () {
                            Get.to(() => OtpScreen(
                                  id: widget.id,
                                ));
                          },
                          icon: Icon(Icons.lock)),
                      IconButton(
                          onPressed: () async {
                            showDilog(
                              context,
                              "Are you sure you want to delete the note?",
                              type: QuickAlertType.warning,
                              onConfirmBtnTap: () async {
                                String userId =
                                    sharedPreferences.getString('id') ?? '';
                                var taskSnapshot = await FirebaseFirestore
                                    .instance
                                    .collection('users')
                                    .doc(userId)
                                    .collection('notes')
                                    .doc(widget.id)
                                    .delete();
                                Get.off(() => MainScreen());
                              },
                            );
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isEdit = !isEdit;
                              _focusOnTextField();
                            });
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            isStar = !isStar;
                          });
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(sharedPreferences.getString('id'))
                              .collection('notes')
                              .doc(widget.id)
                              .update({
                            'star': isStar,
                          });
                        },
                        icon: !isStar
                            ? Icon(
                                Icons.star_border,
                                color: ColorManager.black,
                              )
                            : Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Opacity(
                    opacity: textOpacity,
                    child: TextFormField(
                      focusNode: _focusNode,
                      readOnly: !isEdit,
                      initialValue: widget.title,
                      onChanged: (value) {
                        title = value.toString();
                      },
                      decoration: InputDecoration(
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
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Text(
                  //     widget.title,
                  //     style: MangeStyles().getBoldStyle(
                  //       color: ColorManager.black,
                  //       fontSize: FontSize.s20,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Opacity(
                      opacity: textOpacity,
                      child: TextFormField(
                        readOnly: !isEdit,
                        initialValue: widget.des,
                        maxLines: null,
                        onChanged: (value) {
                          note = value.toString();
                        },
                        decoration: InputDecoration(
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
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
