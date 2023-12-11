import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/auth/otp_screeen/widget/pinIn_put_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  int _remainingTime = 60; // تحديد الوقت المحدد للانتظار هنا
  // bool _isTimerRunning = false; // تحديد متغير لتتبع تشغيل العداد التنازلي
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = ColorManager.kPrimary;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    final borderColor = ColorManager.black.withOpacity(0.5);

    final defaultPinTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Password'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Spacer(), Spacer(),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Password',
              style: MangeStyles().getBoldStyle(
                color: ColorManager.kTextlightgray,
                fontSize: FontSize.s16,
              ),
            ),
          ),
          SizedBox(
            height: 45,
          ),
          PinInPutWidget(
            formKey: formKey,
            pinController: pinController,
            focusNode: focusNode,
            defaultPinTheme: defaultPinTheme,
            focusedBorderColor: focusedBorderColor,
            fillColor: fillColor,
          ),
          SizedBox(
            height: 20,
          ),
          // _isTimerRunning
          //     ? Text(
          //         'Resend code in $_remainingTime s',
          //         style: MangeStyles().getBoldStyle(
          //           color: ColorManager.kTextlightgray,
          //           fontSize: FontSize.s16,
          //         ),
          //       )
          //     : TextButton(
          //         onPressed: _isTimerRunning
          //             ? null
          //             : () {
          //                 // يتم بدء العداد التنازلي هنا
          //                 setState(() {
          //                   _isTimerRunning = true;
          //                 });
          //                 startTimer();
          //               },
          //         child: Text(
          //           'Resend code',
          //           style: MangeStyles().getBoldStyle(
          //             color: ColorManager.kPrimary,
          //             fontSize: FontSize.s16,
          //           ),
          //         ),
          //       ),
          // Spacer(),
          // Spacer(),

          // Spacer(),
          TextButton(
            onPressed: () {
              focusNode.unfocus();
              //    setState(() {
              //   isStar = !isStar;
              // });
              if (pinController.text.length == 4) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(sharedPreferences.getString('id'))
                    .collection('notes')
                    .doc(widget.id)
                    .update({
                  'pass': pinController.text,
                });
                Get.back();
              }

              // formKey.currentState!.validate();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });
      if (_remainingTime <= 0) {
        // يتم إيقاف العداد التنازلي هنا
        timer.cancel();
        setState(() {
          // _isTimerRunning = false;
          _remainingTime = 60;
        });
      }
    });
  }
}
