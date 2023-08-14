import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/screen/create_task_screen/create_task_controller/create_task_controller.dart';

class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String selectedValue = 'Meditation'; // Initially selected value

  @override
  Widget build(BuildContext context) {
    final CreateTaskController _controller = Get.put(CreateTaskController());
    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border.all(color: ColorManager.grey2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _controller.catogery,
          onChanged: (newValue) {
            setState(() {
              _controller.catogery = newValue!;
            });
          },
          style: TextStyle(color: Colors.black, fontSize: 18),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          items: <String>[
            'Learn Programming',
            'Dumbbell Exercise',
            'Tech Exploration',
            'Fixing Smartphone',
            'Meditation',
            'Reading Books',

            // Add more options as needed
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          dropdownColor: Colors.grey[100],
          elevation: 4,
          isExpanded: true,
        ),
      ),
    );
  }
}
