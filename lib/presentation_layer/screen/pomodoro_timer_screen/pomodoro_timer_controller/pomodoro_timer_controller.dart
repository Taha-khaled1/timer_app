import 'dart:math';

// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/pomodoro_timer_screen.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/widget/CircularPomodoro.dart';
import 'package:task_manger/presentation_layer/screen/succss_screen.dart';

class PomodoroTimerController extends GetxController {
  bool isload = true;
  final TaskModel? taskModel;
  late int duration; // Declare x without initializing it here

  PomodoroTimerController(this.taskModel) {
    // x = taskModel!.pomotime;  // Initialize x inside the constructor
    duration = (taskModel!.pomotime! * 60);
  }
  StopWatchTimer? stopWatchTimer = null;
  // int x=taskModel!.pomotime!;

  // final CountDownController controller = CountDownController();
  DateTime firstDateTime = DateTime.now();
  static const String _keyPrefix = 'user_activity_';
  int endWork = 1;
  final List<Color> colorsPomodoro = [
    ColorManager.kPrimary,
    Color(0xFF1AB65C),
    Color(0xFF246BFD),
  ];
  int randomIndex = Random().nextInt(2);
  bool isplay = false;
  bool isFirstplay = true;

  void changePlay(bool value) {
    isplay = value;
    update();
  }

  void changeupdate() {
    update();
  }

  void changeFirstPlay() {
    isFirstplay = false;
    update();
  }

  void startPomo() {
    stopWatchTimer!.onStartTimer();
    update();
  }

  void resumePomo() {
    stopWatchTimer!.onStartTimer();
    update();
  }

  void pausePomo() {
    stopWatchTimer!.onStopTimer();
    update();
  }

  void restartPomo() {
    stopWatchTimer!.onResetTimer();
    stopWatchTimer!.onStartTimer();
    update();
  }

  void playButton() {
    prinetMin();
    if (isFirstplay == true) {
      startPomo();
      changePlay(true);
      changeFirstPlay();
    } else {
      if (isplay == false) {
        resumePomo();
        changePlay(true);
      } else {
        pausePomo();
        changePlay(false);
      }
    }
  }

  void prinetMin() {
    final formattedDate =
        "${firstDateTime.year}-${firstDateTime.month}-${firstDateTime.day}";
    final key = '$_keyPrefix$formattedDate';
    var m = sharedPreferences.getInt(key);
    print('$key  -- ${m}');
  }

  @override
  void onInit() async {
    duration = (taskModel!.pomotime! * 60);
    // PomodoroTimerController pomodoroTimerController = Get.find();
    stopWatchTimer = await StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(duration),
      onChangeRawMinute: (value) {
        print('onChangeRawMinute $value');
        UserActivityTracker.logActivity(firstDateTime, 1);
      },
      onStopped: () {
        print('onStopped');
      },
      onEnded: () async {
        if (endWork < taskModel!.workSessions!) {
          showAlert(taskModel!);
        } else {
          Get.off(() => SuccssScreen());
          FirebaseFirestore.instance
              .collection('users')
              .doc(sharedPreferences.getString('id'))
              .collection('tasks')
              .doc(taskModel!.id)
              .update({
            'done': true,
          });
        }
      },
    );

    await stopWatchTimer!.minuteTime
        .listen((value) => print('minuteTime $value'));
    await stopWatchTimer!.fetchStopped
        .listen((value) => print('stopped from stream'));
    await stopWatchTimer!.fetchEnded
        .listen((value) => print('ended from stream'));
    // stopWatchTimer!.onStartTimer();
    isload = false;
    update();
    super.onInit();
  }
}
      // onChange: (value) => print('onChange $value'),
      // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
      
    // stopWatchTimer.rawTime.listen((value) =>
    //     print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    // stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));