import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/auth/otp_screeen/otp_screeen.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
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

  late bool isStar;
  @override
  void initState() {
    isStar = widget.star;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      // appBar: appbarMain(title: 'note detalis'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
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
                          String userId =
                              sharedPreferences.getString('id') ?? '';
                          var taskSnapshot = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .collection('notes')
                              .doc(widget.id)
                              .delete();
                          Get.off(() => MainScreen());
                        },
                        icon: Icon(Icons.delete)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
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
                              color: ColorManager.white,
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
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.title,
                    style: MangeStyles().getBoldStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s20,
                    ),
                  ),
                ),
                Opacity(
                  opacity: textOpacity,
                  child: TextFormField(
                    readOnly: true,
                    initialValue: widget.des,
                    maxLines: 100,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
