import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/presentation_layer/utils/shard_function/formmat_time.dart';

class CreateTaskController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  double sliderValue1 = 0;
  double sliderValue2 = 0;
  double sliderValue3 = 0;

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
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      // Update the selected time in the text field

      String formattedTime = formatTimeOfDay(picked);
      timeController.text = formattedTime;
    }
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    print('object');
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      // Update the selected date in the text field

      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      update();
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
