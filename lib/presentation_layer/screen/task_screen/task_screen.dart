import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/screen/task_screen/widget/task_info_data_card.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

import 'task_controller/task_controller.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final TaskController _controller = Get.put(TaskController());
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbarMain(title: 'Pomodoro Task'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: deviceInfo.localWidth * 0.03),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                    builder: (ctx, snapshot) {
                      // Checking if future is resolved or not
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If we got an error
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(fontSize: 18),
                            ),
                          );

                          // if we got our data
                        } else if (snapshot.hasData) {
                          final data = snapshot.data;
                          int totalTasks = data!.length;
                          return Column(
                            children: [
                              EasyDateTimeLine(
                                initialDate: dateTime,
                                onDateChange: (selectedDate) {
                                  dateTime = selectedDate;
                                  // _controller.getTasksBydata(selectedDate);
                                  setState(() {});
                                },
                                dayProps: const EasyDayProps(
                                  inactiveDayDecoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color: Color(0xFFF5F5F5),
                                  ),
                                  activeDayDecoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    gradient: LinearGradient(
                                      begin: Alignment(0.96, -0.28),
                                      end: Alignment(-0.96, 0.28),
                                      colors: [
                                        Color(0xFF7306FD),
                                        Color(0xFFB173FF)
                                      ],
                                    ),
                                  ),
                                ),
                                headerProps: const EasyHeaderProps(
                                  selectedDateFormat:
                                      SelectedDateFormat.fullDateDMonthAsStrY,
                                ),
                              ),
                              SizedBox(height: 20),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: totalTasks,
                                itemBuilder: (BuildContext context, int index) {
                                  int ind = taskmodelList.indexWhere(
                                      (element) =>
                                          element.title ==
                                          data[index]['catogery']);
                                  return TaskInfoDataCard(
                                    taskModel: TaskModel(
                                      color: taskmodelList[ind].color,
                                      image: taskmodelList[ind].image,
                                      title: taskmodelList[ind].title,
                                      subtitle: taskmodelList[ind].subtitle,
                                      id: data[index]['timestamp'],
                                      data: data[index]['datatime'],
                                      time: data[index]['timeOfDay'],
                                      isdone: data[index]['done'],
                                      taskName: data[index]['title'],
                                    ),
                                    taslength: totalTasks,index: index,
                                  );
                                },
                              ),
                            ],
                          );
                        }
                      }

                      // Displaying LoadingSpinner to indicate waiting state
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },

                    // Future that needs to be resolved
                    // inorder to display something on the Canvas
                    future: _controller.getTasksBydata(dateTime),
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
