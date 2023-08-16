import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/auth/LoginScreen/login_screen.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

customLogoutShowBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: ColorManager.background,
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    )),
    builder: (BuildContext context) {
      return Container(
        height: 250,
        padding: EdgeInsets.all(16.0),
        child: InfoWidget(
          builder: (context, deviceInfo) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Logout',
                    style: MangeStyles().getBoldStyle(
                      color: ColorManager.kPrimary,
                      fontSize: FontSize.s18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Are you sure you want to log out?',
                    style: MangeStyles().getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      boxShadowValue: BoxShadow(),
                      width: deviceInfo.localWidth * 0.42,
                      rectangel: 25,
                      haigh: 60,
                      color: Color(0xFFFFEEEF),
                      text: "Cancel",
                      colorText: Colors.black,
                      press: () {
                        Get.back();
                      },
                    ),
                    CustomButton(
                      width: deviceInfo.localWidth * 0.42,
                      rectangel: 25,
                      haigh: 60,
                      color: ColorManager.kPrimaryButton,
                      text: "Yes, Logout",
                      press: () async {
                        await FirebaseAuth.instance.signOut();
                        sharedPreferences.remove('id');
                        sharedPreferences.setString("lev", '1');
                        Get.offAll(() => LoginScreen());
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
