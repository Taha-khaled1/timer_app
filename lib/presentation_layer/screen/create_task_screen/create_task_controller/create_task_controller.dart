import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/notification_service/notification_service.dart';
import 'package:task_manger/presentation_layer/screen/create_task_screen/create_task_screen.dart';
import 'package:task_manger/presentation_layer/screen/subscribe_screen/subscription_screen.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';
import 'package:task_manger/presentation_layer/utils/shard_function/convert-time.dart';
import 'package:task_manger/presentation_layer/utils/shard_function/formmat_time.dart';
import 'package:task_manger/presentation_layer/utils/shard_function/issubscribe.dart';
import 'package:task_manger/presentation_layer/utils/shard_function/printing_function_red.dart';

class CreateTaskController extends GetxController {
  Map? argument = Get.arguments;
  var selectedColorIndex = (-1).obs;
  int? selectedColor;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  int pomotime = 25;
  double sliderValue1 = 3;
  double sliderValue2 = 15;
  double sliderValue3 = 8;
  late TaskModel? taskModel;
  bool isloading = false;
  String? title;
  int? longBreak, workSessions, shortBreak;
  DateTime? dataTime;
  TimeOfDay? timeOfDay;
  String catogery = 'Meditation';
  Future<void> intalizedData() async {
    // argument = await Get.arguments;
    taskModel = argument?['taskModel'];
    if (argument == null) {
      pomotime = 25;
      sliderValue1 = 3;
      sliderValue2 = 15;
      sliderValue3 = 8;
    } else {
      title = taskModel!.taskName!;

      print("$title       object      ${taskModel!.taskName!}");
      selectedColor = taskModel!.color!.value;
      selectedColorIndex =
          colorsTask.indexWhere((element) => element == selectedColor).obs;
      pomotime = taskModel!.pomotime!;
      sliderValue1 = taskModel!.workSessions!.toDouble();
      sliderValue2 = taskModel!.longBreak!.toDouble();
      sliderValue3 = taskModel!.shortBreak!.toDouble();
    }
    update();
  }

  TabAppController tabController = Get.find();
  void setSliderValue(int value) {
    pomotime = value;
    update();
  }

  void setSliderValue1(double value) {
    sliderValue1 = value;
    update();
  }

  void setSliderValue2(double value) {
    sliderValue2 = value;
    update();
  }

  void setSliderValue3(double value) {
    sliderValue3 = value;
    update();
  }

  Future<void> selectTime(BuildContext context) async {
    timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (timeOfDay != null) {
      // Update the selected time in the text field
      // print(timeOfDay!.periodOffset);
      // print(timeOfDay!.hourOfPeriod);
      // print(timeOfDay!.period.name);
      String formattedTime = formatTimeOfDay(timeOfDay!);
      timeController.text = formattedTime;
    }
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    print('object');
    dataTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (dataTime != null && dataTime != DateTime.now()) {
      // Update the selected date in the text field

      dateController.text =
          "${dataTime!.day}/${dataTime!.month}/${dataTime!.year}";
      update();
    }
  }

  Future<void> editeTask() async {
    isloading = true;
    update();
    if (title == null || title!.length < 3) {
      showToast('Please make sure you put a correct title');
      isloading = false;
      update();
      return;
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences.getString('id'))
        .collection('tasks')
        .doc(taskModel!.id)
        .update({
      'title': title,
      'longBreak': sliderValue2.toInt(),
      'pomotime': pomotime,
      'workSessions': sliderValue1.toInt(),
      'shortBreak': sliderValue3.toInt(),
      'color': selectedColor,
    });
    showToast('The task has been modified successfully');
    isloading = false;
    update();
    Get.offAll(() => MainScreen());
  }

  void createTask(BuildContext ctx) async {
    if (!isSubScribe()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          ctx,
          MaterialPageRoute(builder: (context) => SubscriptionScreen()),
        );
      });
      return;
    }
    isloading = true;
    update();
    try {
      if (timeOfDay == null || dataTime == null) {
        showToast('Please make sure you put the time and date');
        isloading = false;
        update();
        return;
      }

      if (title == null || title!.length < 3) {
        showToast('Please make sure you put a correct title');
        isloading = false;
        update();
        return;
      }
      if (selectedColor == null) {
        showToast('Please make sure you put a color');
        isloading = false;
        update();
        return;
      }
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      Random random = Random();
      int randomIndex = random.nextInt(notificationList.length);
      String timeString =
          '${timeOfDay!.hour}:${timeOfDay!.minute} ${timeOfDay!.period.name}';
      String dateString =
          '${dataTime!.year}/${dataTime!.month}/${dataTime!.day}';
      final DateTime combinedDateTime =
          await convertTDataTime(timeString, dateString);
      printRedColor(convertTo12HourFormat(timeOfDay!.hour, timeOfDay!.minute));
      printRedColor("${timeOfDay!.hour} -- ${timeOfDay!.minute}");
      if (combinedDateTime.isBefore(DateTime.now())) {
        showToast('Must be a date in the future');
        isloading = false;
        update();
        return;
        // Add any other logic you want to execute when combinedDateTime is in the past
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(sharedPreferences.getString('id'))
            .collection('tasks')
            .doc(timestamp)
            .set({
          'title': title,
          'longBreak': sliderValue2.toInt(),
          'pomotime': pomotime,
          'workSessions': sliderValue1.toInt(),
          'shortBreak': sliderValue3.toInt(),
          'timeOfDay':
              convertTo12HourFormat(timeOfDay!.hour, timeOfDay!.minute),
          'datatime': '${dataTime!.year}/${dataTime!.month}/${dataTime!.day}',
          'catogery': catogery,
          'color': selectedColor,
          'done': false,
          'timestamp': timestamp,
        });

        await NotificationService().alarmCallback(
          des: notificationList[randomIndex].description,
          scheduleDate: combinedDateTime,
          title: notificationList[randomIndex].title,
        );
        showToast('The task was created successfully');
        isloading = false;
        update();
        Get.off(() => MainScreen());
        // tabController.changeTabIndex(0);
      }
    } catch (e) {
      isloading = false;
      update();
      print(e.toString());
      showToast('Must be a date in the future');
    }
    isloading = false;
    update();
  }

  @override
  void onInit() async {
    await intalizedData();
    print(
        "===========$argument=====${argument?['taskModel']}==${argument?['taskModel']}====");
    super.onInit();
  }

  @override
  void onClose() {
    dateController.dispose();
    timeController.dispose();
    super.onClose();
  }

  // ... Add your _selectDate and _selectTime functions here
}

class NotificationInfo {
  final String title;
  final String description;

  NotificationInfo(this.title, this.description);
}

List<NotificationInfo> notificationList = [
  NotificationInfo(
    "Time to Shine",
    "Your task is waiting for you. It's time to make progress and shine bright!",
  ),
  NotificationInfo(
    "Leap into Productivity",
    "Seize the moment! Dive into your task and make today a productive leap forward.",
  ),
  NotificationInfo(
    "A Journey Begins",
    "Embark on your journey toward completing a task. Every step counts!",
  ),
  NotificationInfo(
    "Craft Your Success",
    "The path to success is paved with effort. Craft your success story with this task.",
  ),
  NotificationInfo(
    "Rise and Conquer",
    "Wake up, conquer your tasks, and make today a stepping stone to your goals.",
  ),
  NotificationInfo(
    "Unleash Your Potential",
    "Your potential is limitless. Start this task and watch your capabilities unfold.",
  ),
  NotificationInfo(
    "Create, Transform, Elevate",
    "With this task, you have the power to create, transform, and elevate your journey.",
  ),
  NotificationInfo(
    "A Task Awaits Your Touch",
    "This task is waiting for your touch of brilliance. Make it your masterpiece.",
  ),
  NotificationInfo(
    "Write Your Chapter",
    "Life is a book, and every task is a chapter. Today, you're the author.",
  ),
  NotificationInfo(
    "Seize Your Destiny",
    "Destiny favors the proactive. Seize your destiny by completing this task.",
  ),
];
