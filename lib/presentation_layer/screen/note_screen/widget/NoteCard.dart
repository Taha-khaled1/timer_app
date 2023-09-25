import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/auth/otp_screeen/otp_screeen.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/utils/sub_string/sub_string.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({
    super.key,
    required this.title,
    required this.des,
    required this.star,
    required this.id,
  });
  final String title, des, id;
  final bool star;
  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  late bool isStar;
  @override
  void initState() {
    isStar = widget.star;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(OtpScreen());
      },
      child: Container(
        width: 380,
        height: 120,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.96, -0.28),
            end: Alignment(-0.96, 0.28),
            colors: [Color(0xFF7306FD), Color(0xFFB173FF)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              child: GestureDetector(
                onTap: () async {
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
                child: !isStar
                    ? Icon(
                        Icons.star_border,
                        color: ColorManager.white,
                      )
                    : Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
              ),
            ),
            Positioned(
              top: 45,
              // bottom: 0,
              right: 0,
              left: 0,
              child: Text(
                subString(widget.title, 8),
                style: MangeStyles().getRegularStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s22,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
