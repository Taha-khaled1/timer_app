import 'package:flutter/material.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.title,
    required this.des,
  });
  final String title, des;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: MangeStyles().getRegularStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s27,
                ),
                textAlign: TextAlign.center,
              ),
              Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.white,
                size: 30,
              )
            ],
          ),
          SizedBox(height: 17),
          Text(
            des,
            style: MangeStyles().getRegularStyle(
              color: ColorManager.white,
              fontSize: FontSize.s12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
