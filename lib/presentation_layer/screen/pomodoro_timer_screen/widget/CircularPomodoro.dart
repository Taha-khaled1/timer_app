import 'dart:async';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/main.dart';
// import 'package:task_manger/presentation_layer/resources/color_manager.dart';
// import 'package:task_manger/presentation_layer/resources/font_manager.dart';
// import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
// import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/pomodoro_timer_controller/pomodoro_timer_controller.dart';
// import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/pomodoro_timer_screen.dart';
// import 'package:task_manger/presentation_layer/screen/succss_screen.dart';

// class CircularPomodoro extends StatefulWidget {
//   const CircularPomodoro({Key? key, required this.taskModel}) : super(key: key);

//   final TaskModel taskModel;
//   @override
//   State<CircularPomodoro> createState() => _CircularPomodoroState();
// }

// class _CircularPomodoroState extends State<CircularPomodoro> {
//   Timer? timer;
//   DateTime firstDateTime = DateTime.now();
//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     PomodoroTimerController pomodoroTimerController =
//         Get.put(PomodoroTimerController(widget.taskModel));
//     return Center(
//       child: CircularCountDownTimer(
//         duration: widget.taskModel.pomotime! * 60,
//         // initialDuration: 100,
//         controller: pomodoroTimerController.controller,
//         width: MediaQuery.of(context).size.width / 2,
//         height: MediaQuery.of(context).size.height / 2,
//         ringColor: Colors.grey[300]!,
//         ringGradient: null,
//         fillColor: ColorManager.kPrimary,
//         fillGradient: null,
//         backgroundColor: ColorManager.background,
//         backgroundGradient: null,
//         strokeWidth: 20.0,
//         strokeCap: StrokeCap.round,
//         textStyle: MangeStyles().getBoldStyle(
//           color: ColorManager.black,
//           fontSize: FontSize.s40,
//         ),
//         textFormat: CountdownTextFormat.MM_SS,
//         isReverse: true,
//         isReverseAnimation: false,
//         isTimerTextShown: true,
//         autoStart: false,
//         onStart: () {
//           timer = Timer.periodic(Duration(minutes: 1), (_) {
//             // final formattedDate =
//             //     "${firstDateTime!.year}-${firstDateTime!.month}-${firstDateTime!.day}";
//             UserActivityTracker.logActivity(firstDateTime, 1);
//           });

//           debugPrint('Countdown Started');
//         },
//         onComplete: () async {
//           if (pomodoroTimerController.endWork <
//               widget.taskModel.workSessions!) {
//             showAlert(widget.taskModel);
//           } else {
//             Get.off(() => SuccssScreen());
//             FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(sharedPreferences.getString('id'))
//                 .collection('tasks')
//                 .doc(widget.taskModel.id)
//                 .update({
//               'done': true,
//             });
//           }
//         },
//         onChange: (String timeStamp) {
//           print('object : $timeStamp');
//           debugPrint('Countdown Changed $timeStamp');
//         },
//         timeFormatterFunction: (defaultFormatterFunction, duration) {
//           if (duration.inSeconds == 0) {
//             // only format for '0'
//             return "END";
//           } else {
//             // other durations by it's default format
//             return Function.apply(defaultFormatterFunction, [duration]);
//           }
//         },
//       ),
//     );
//   }
// }

class UserActivityTracker {
  static const String _keyPrefix = 'user_activity_';
  static const String _keyPrefixtotal = 'user_activity';
  static Future<void> logActivity(DateTime dateTime, int minutes) async {
    final formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    final key = '$_keyPrefix$formattedDate';
    final existingMinutes = sharedPreferences.getInt(key) ?? 0;
    final totalMinutes = sharedPreferences.getInt(_keyPrefixtotal) ?? 0;
    sharedPreferences.setInt(key, existingMinutes + 1);
    sharedPreferences.setInt(_keyPrefixtotal, totalMinutes + 1);
    print("---------> ${existingMinutes + 1} : ${totalMinutes + 1}");
  }

  static Future<int> getMinutesForDay(DateTime dateTime) async {
    final formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    final key = '$_keyPrefix$formattedDate';
    return sharedPreferences.getInt(key) ?? 0;
  }
}
