import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/widget/CircularPomodoro.dart';

class PomodoroTimerController extends GetxController {
  PomodoroTimerController();

  final int duration = (25 * 60);
  final CountDownController controller = CountDownController();
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
    controller.start();
    update();
  }

  void resumePomo() {
    controller.resume();
    update();
  }

  void pausePomo() {
    controller.pause();
    update();
  }

  void restartPomo() {
    controller.restart();
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
  void onInit() {
    super.onInit();
  }
}
