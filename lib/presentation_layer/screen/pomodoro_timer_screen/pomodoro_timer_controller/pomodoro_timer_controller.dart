import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';

class PomodoroTimerController extends GetxController {
  final int duration = (25 * 60);
  final CountDownController controller = CountDownController();
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

  @override
  void onInit() {
    super.onInit();
  }
}
