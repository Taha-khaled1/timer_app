import 'package:flutter/material.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';

class Tag extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  Tag({
    required this.text,
    this.color = ColorManager.kPrimaryconst,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
