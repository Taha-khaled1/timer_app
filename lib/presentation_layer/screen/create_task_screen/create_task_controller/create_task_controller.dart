import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';
import 'package:task_manger/presentation_layer/utils/shard_function/formmat_time.dart';

class CreateTaskController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  double sliderValue1 = 1;
  double sliderValue2 = 1;
  double sliderValue3 = 1;
  TabAppController tabController = Get.find();
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

  String? title;
  int? longBreak, workSessions, shortBreak;
  DateTime? dataTime;
  TimeOfDay? timeOfDay;
  String catogery = 'Meditation';
  void createTask() async {
    try {
      if (timeOfDay == null || dataTime == null) {
        showToast('Please make sure you put the time and date');
        return;
      }

      if (title == null || title!.length < 3) {
        showToast('Please make sure you put a correct title');
        return;
      }
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(sharedPreferences.getString('id'))
          .collection('tasks')
          .doc(timestamp)
          .set({
        'title': title,
        'longBreak': sliderValue1.toInt(),
        'workSessions': sliderValue2.toInt(),
        'shortBreak': sliderValue3.toInt(),
        'timeOfDay':
            '${timeOfDay!.hour}:${timeOfDay!.minute} ${timeOfDay!.period.name}',
        'datatime': '${dataTime!.year}/${dataTime!.month}/${dataTime!.day}',
        'catogery': catogery,
        'done': false,
        'timestamp': timestamp,
      });

      showToast('The task was created successfully');
      tabController.changeTabIndex(0);
    } catch (e) {
      print(e.toString());
      showToast('There is a problem, please try later');
    }
  }

  @override
  void onClose() {
    dateController.dispose();
    timeController.dispose();
    super.onClose();
  }

  // ... Add your _selectDate and _selectTime functions here
}
