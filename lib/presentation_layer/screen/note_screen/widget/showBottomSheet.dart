import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';

customShowBottomSheet(BuildContext context, Function setStateCallback) {
  String title = '';
  String message = '';
  showModalBottomSheet(
    backgroundColor: ColorManager.background,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    isScrollControlled: true, // Added this line
    builder: (BuildContext context) {
      return Container(
        height: 640,
        child: Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Title',
                  style: MangeStyles().getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                onChanged: (p0) {
                  title = p0.toString();
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: ColorManager.fillColor,
                  labelText: 'Title',
                  hintStyle: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: 0.20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Notes',
                  style: MangeStyles().getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              TextFormField(
                onChanged: (p0) {
                  message = p0.toString();
                },
                minLines: 5,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: ColorManager.fillColor,
                  labelText: 'Description',
                  hintStyle: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: 0.20,
                  ),
                ),
              ),
              SizedBox(height: 15),
              CustomButton(
                width: double.infinity,
                haigh: 60,
                color: ColorManager.kPrimary,
                text: 'Create New Note',
                press: () async {
                  if (message.isEmpty || title.isEmpty) {
                    showToast('There are some empty fields');
                  } else {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(sharedPreferences.getString('id'))
                        .collection('notes')
                        .add({
                      'title': title,
                      'note': message,
                    });
                    Get.back();
                    showToast('Note added successfully');
                  }
                },
                rectangel: 25,
              ),
            ],
          ),
        ),
      );
    },
  );
}
