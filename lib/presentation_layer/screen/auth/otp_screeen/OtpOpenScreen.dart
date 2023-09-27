import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/auth/create_password/create_password.dart';
import 'package:task_manger/presentation_layer/screen/auth/otp_screeen/widget/pinIn_put_widget.dart';
import 'package:task_manger/presentation_layer/screen/note_screen/note_detalis_screen.dart';

class OtpOpenScreen extends StatefulWidget {
  const OtpOpenScreen(
      {Key? key,
      required this.id,
      required this.title,
      required this.des,
      this.pass,
      required this.star})
      : super(key: key);

  final String title, des, id;
  final String? pass;
  final bool star;
  @override
  State<OtpOpenScreen> createState() => _OtpOpenScreenState();
}

class _OtpOpenScreenState extends State<OtpOpenScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

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
            validator: (value) {
              print(widget.pass);
              return value == widget.pass ? null : 'Pin is incorrect';
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Get.to(() => NoteDetalis(
                      des: widget.des,
                      id: widget.id,
                      star: widget.star,
                      title: widget.title,
                      pass: widget.pass,
                    ));
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
