import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: ColorManager.kPrimary,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
