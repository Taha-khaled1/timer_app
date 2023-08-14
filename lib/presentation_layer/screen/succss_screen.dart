import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class SuccssScreen extends StatelessWidget {
  const SuccssScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InfoWidget(
          builder: (context, deviceInfo) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Congratulations, you have successfully completed the task',
                    style: MangeStyles().getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  LottieBuilder.asset('assets/json/sucss.json'),
                  CustomButton(
                    width: deviceInfo.localWidth * 0.85,
                    haigh: 60,
                    color: ColorManager.kPrimary,
                    text: 'Back Home',
                    press: () {
                      Get.offAll(() => MainScreen());
                    },
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
