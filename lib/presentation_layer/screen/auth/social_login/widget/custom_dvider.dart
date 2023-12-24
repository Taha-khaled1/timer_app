import 'package:flutter/material.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';

class CustomDvider extends StatelessWidget {
  const CustomDvider({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        children: [
          Expanded(
              child: Divider(
            color: ColorManager.kTextlightgray.withOpacity(0.4),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: MangeStyles().getBoldStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: FontSize.s16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              child: Divider(
            color: ColorManager.kTextlightgray.withOpacity(0.4),
          )),
        ],
      ),
    );
  }
}
