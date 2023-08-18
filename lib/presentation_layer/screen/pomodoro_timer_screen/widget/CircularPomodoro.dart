import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/main.dart';

import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/pomodoro_timer_controller/pomodoro_timer_controller.dart';
import 'package:task_manger/presentation_layer/screen/succss_screen.dart';

class CircularPomodoro extends StatefulWidget {
  const CircularPomodoro({Key? key, required this.taskModel}) : super(key: key);

  final TaskModel taskModel;
  @override
  State<CircularPomodoro> createState() => _CircularPomodoroState();
}

class _CircularPomodoroState extends State<CircularPomodoro> {
  Timer? timer;
  DateTime firstDateTime = DateTime.now();
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PomodoroTimerController pomodoroTimerController =
        Get.put(PomodoroTimerController());
    return Center(
      child: CircularCountDownTimer(
        // Countdown duration in Seconds.
        duration: pomodoroTimerController.duration,

        // Countdown initial elapsed Duration in Seconds.
        initialDuration: 0,

        // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
        controller: pomodoroTimerController.controller,

        // Width of the Countdown Widget.
        width: MediaQuery.of(context).size.width / 2,

        // Height of the Countdown Widget.
        height: MediaQuery.of(context).size.height / 2,

        // Ring Color for Countdown Widget.
        ringColor: Colors.grey[300]!,

        // Ring Gradient for Countdown Widget.
        ringGradient: null,

        // Filling Color for Countdown Widget.
        fillColor: ColorManager.kPrimary,

        // Filling Gradient for Countdown Widget.
        fillGradient: null,

        // Background Color for Countdown Widget.
        backgroundColor: ColorManager.background,

        // Background Gradient for Countdown Widget.
        backgroundGradient: null,

        // Border Thickness of the Countdown Ring.
        strokeWidth: 20.0,

        // Begin and end contours with a flat edge and no extension.
        strokeCap: StrokeCap.round,

        // Text Style for Countdown Text.
        textStyle: MangeStyles().getBoldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s40,
        ),

        // Format for the Countdown Text.
        textFormat: CountdownTextFormat.MM_SS,

        // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
        isReverse: true,

        // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
        isReverseAnimation: false,

        // Handles visibility of the Countdown Text.
        isTimerTextShown: true,

        // Handles the timer start.
        autoStart: false,

        // This Callback will execute when the Countdown Starts.
        onStart: () {
          timer = Timer.periodic(Duration(minutes: 1), (_) {
            // final formattedDate =
            //     "${firstDateTime!.year}-${firstDateTime!.month}-${firstDateTime!.day}";
            UserActivityTracker.logActivity(firstDateTime, 1);
          });

          debugPrint('Countdown Started');
        },

        // This Callback will execute when the Countdown Ends.
        onComplete: () async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(sharedPreferences.getString('id'))
              .collection('tasks')
              .doc(widget.taskModel.id)
              .update({
            'done': true,
          });
          Get.to(() => SuccssScreen());
        },

        // This Callback will execute when the Countdown Changes.
        onChange: (String timeStamp) {
          // Here, do whatever you want
          print('object : $timeStamp');
          debugPrint('Countdown Changed $timeStamp');
        },

        /* 
            * Function to format the text.
            * Allows you to format the current duration to any String.
            * It also provides the default function in case you want to format specific moments
              as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
              the default behavior.
          */
        timeFormatterFunction: (defaultFormatterFunction, duration) {
          if (duration.inSeconds == 0) {
            // only format for '0'
            return "Start";
          } else {
            // other durations by it's default format
            return Function.apply(defaultFormatterFunction, [duration]);
          }
        },
      ),
    );
  }
}

class UserActivityTracker {
  static const String _keyPrefix = 'user_activity_';

  static Future<void> logActivity(DateTime dateTime, int minutes) async {
    final formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    final key = '$_keyPrefix$formattedDate';
    final existingMinutes = sharedPreferences.getInt(key) ?? 0;
    sharedPreferences.setInt(key, existingMinutes + minutes);
  }

  static Future<int> getMinutesForDay(DateTime dateTime) async {
    final formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    final key = '$_keyPrefix$formattedDate';
    return sharedPreferences.getInt(key) ?? 0;
  }
}
