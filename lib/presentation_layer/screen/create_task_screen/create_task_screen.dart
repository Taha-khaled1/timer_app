import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/components/custom_text_field.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

import 'create_task_controller/create_task_controller.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateTaskController _controller = Get.put(CreateTaskController());
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbarProfile(title: 'Create New Task'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: deviceInfo.localWidth * 0.05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Title',
                    style: MangeStyles().getBoldStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  CustomTextfield(
                    valid: (p0) {},
                    onsaved: (p0) {},
                    titel: 'Task Title',
                    width: deviceInfo.localWidth * 1,
                    height: 60,
                  ),
                  SizedBox(height: 20),
                  GetBuilder<CreateTaskController>(
                    builder: (controller) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Date',
                                  style: MangeStyles().getBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s18,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: 10),
                              CustomTextfield(
                                readOnly: true,
                                textController: controller.dateController,
                                valid: (p0) {},
                                onsaved: (p0) {},
                                onTap: () => _controller.selectDate(context),
                                titel: 'Date',
                                width: deviceInfo.localWidth * 0.43,
                                icon: Icons.calendar_month,
                                height: 60,
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Time',
                                style: MangeStyles().getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              CustomTextfield(
                                readOnly: true,
                                textController: controller.timeController,
                                valid: (p0) {},
                                onsaved: (p0) {},
                                onTap: () => controller.selectTime(context),
                                titel: 'Start Time',
                                width: deviceInfo.localWidth * 0.43,
                                icon: Icons.access_time_sharp,
                                height: 60,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Select Category',
                      style: MangeStyles().getBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10),
                  MyDropdownButton(),
                  SizedBox(height: 20),
                  GetBuilder<CreateTaskController>(
                    builder: (controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Working Sessions',
                              style: MangeStyles().getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10),
                          SfSlider(
                            min: 0,
                            max: 8,
                            activeColor: ColorManager.kPrimary,
                            inactiveColor: ColorManager.grey2,
                            value: _controller.sliderValue1.toInt(),
                            interval: 8,
                            showTicks: false,
                            showLabels: true,
                            enableTooltip: true,
                            minorTicksPerInterval: 0,
                            thumbShape: SfThumbShape(),
                            onChanged: (dynamic value) {
                              _controller.setSliderValue1(value);
                            },
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Long Break',
                              style: MangeStyles().getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 20),
                          SfSlider(
                            min: 0.0,
                            max: 8.0,
                            activeColor: ColorManager.kPrimary,
                            inactiveColor: ColorManager.grey2,
                            value: _controller.sliderValue2.toInt(),
                            interval: 8,
                            showTicks: false,
                            showLabels: true,
                            enableTooltip: true,
                            minorTicksPerInterval: 0,
                            thumbShape: SfThumbShape(),
                            onChanged: (dynamic value) {
                              _controller.setSliderValue2(value);
                            },
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Short Break',
                              style: MangeStyles().getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 20),
                          SfSlider(
                            min: 0.0,
                            max: 8.0,
                            activeColor: ColorManager.kPrimary,
                            inactiveColor: ColorManager.grey2,
                            value: _controller.sliderValue3.toInt(),
                            interval: 8,
                            showTicks: false,
                            showLabels: true,
                            enableTooltip: true,
                            minorTicksPerInterval: 0,
                            thumbShape: SfThumbShape(),
                            onChanged: (dynamic value) {
                              _controller.setSliderValue3(value);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    width: deviceInfo.localWidth * 0.9,
                    haigh: 60,
                    color: ColorManager.kPrimary,
                    text: 'Create New Task',
                    press: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String selectedValue = 'Meditation'; // Initially selected value

  @override
  Widget build(BuildContext context) {
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
          value: selectedValue,
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue!;
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
