import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/screen/auth/info_account_screen/widget/custom_circle_Image.dart';
import 'package:task_manger/presentation_layer/screen/home_screen/widget/card_task.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/pomodoro_timer_controller/pomodoro_timer_controller.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/widget/CardPromoTimer.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/src/style_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class PomodoroTimerScreen extends StatelessWidget {
  const PomodoroTimerScreen({Key? key, required this.taskModel})
      : super(key: key);
  // final String image,name,
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    PomodoroTimerController pomodoroTimerController =
        Get.put(PomodoroTimerController());
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Pomodoro Timer'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                CardPromoTimer(
                  taskModel: taskModel,
                  istowSubtitle: true,
                ),
                SizedBox(
                  height: 350,
                  child: CircularPomodoro(),
                ),
                GetBuilder<PomodoroTimerController>(
                  init: PomodoroTimerController(),
                  initState: (_) {},
                  builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (pomodoroTimerController.isplay)
                          CustomCircleImageAsset(
                            radius: 35,
                            image: 'assets/images/reset.png',
                            color: Color(0xFFF5F5F5),
                            onTap: () {
                              pomodoroTimerController.restartPomo();
                              pomodoroTimerController.changePlay(true);
                            },
                          ),
                        SizedBox(width: 15),
                        CustomCircleImageAsset(
                          radius: 50,
                          image: pomodoroTimerController.isplay == true
                              ? 'assets/images/play.png'
                              : 'assets/images/vidio.png',
                          color: Color(0xFF7306FD),
                          onTap: () => pomodoroTimerController.playButton(),
                        ),
                        SizedBox(width: 15),
                        if (pomodoroTimerController.isplay)
                          CustomCircleImageAsset(
                            radius: 35,
                            image: 'assets/images/stop.png',
                            color: Color(0xFFF5F5F5),
                            onTap: () {
                              pomodoroTimerController.restartPomo();
                              pomodoroTimerController.changePlay(true);
                              pomodoroTimerController.pausePomo();
                              pomodoroTimerController.changePlay(false);
                            },
                          ),
                      ],
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CircularPomodoro extends StatefulWidget {
  const CircularPomodoro({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<CircularPomodoro> createState() => _CircularPomodoroState();
}

class _CircularPomodoroState extends State<CircularPomodoro> {
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
          // Here, do whatever you want
          debugPrint('Countdown Started');
        },

        // This Callback will execute when the Countdown Ends.
        onComplete: () {
          // Here, do whatever you want
          debugPrint('Countdown Ended');
        },

        // This Callback will execute when the Countdown Changes.
        onChange: (String timeStamp) {
          // Here, do whatever you want
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
  //  pomodoroTimerController.isplay == true
  //                           ? CustomCircleImageAsset(
  //                               radius: 50,
  //                               image: 'assets/images/play.png',
  //                               color: Color(0xFF7306FD),
  //                               onTap: () {
  //                                 if (pomodoroTimerController.isplay == false) {
  //                                   pomodoroTimerController.startPomo();
  //                                 } else {
  //                                   pomodoroTimerController.resumePomo();
  //                                 }
  //                               },
  //                             )
  //                           : CustomCircleImageAsset(
  //                               radius: 50,
  //                               image: 'assets/images/vidio.png',
  //                               color: Color(0xFF7306FD),
  //                               onTap: () {
  //                                 if (pomodoroTimerController.isplay == false) {
  //                                   pomodoroTimerController.startPomo();
  //                                 } else {
  //                                   pomodoroTimerController.resumePomo();
  //                                 }
  //                               },
  //                             ),