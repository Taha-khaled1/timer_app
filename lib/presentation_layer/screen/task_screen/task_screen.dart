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

  TimeOfDay parseTime(String timeStr) {
    final parts = timeStr.split(' ');
    final timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    if (parts[1].toLowerCase() == 'pm' && hour != 12) {
      hour += 12;
    }

    if (parts[1].toLowerCase() == 'am' && hour == 12) {
      hour = 0;
    }
    print("--> __ ${TimeOfDay(hour: hour, minute: minute)}");
    return TimeOfDay(hour: hour, minute: minute);
  }

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
            child: FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    int totalTasks = data!.length;
                    return ListView.custom(
                      childrenDelegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index == DateTime.now().hour) {
                            return Column(
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: DateTime.now().minute * 1.0,
                                      color: index.isEven
                                          ? Colors.grey[200]
                                          : Colors.white,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 20,
                                      color: index.isEven
                                          ? Colors.grey[200]
                                          : Colors.white,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "$index:00",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 65, top: 43),
                                      child: Transform.translate(
                                        offset: Offset(0, -25),
                                        child: CustomLine(),
                                      ),
                                    ),
                                  ],
                                ),
                                for (var task in data)
                                  if (parseTime(task['timeOfDay']).hour ==
                                      index)
                                    TaskInfoDataCard(
                                      taskModel: TaskModel(
                                        color: taskmodelList[taskmodelList
                                                .indexWhere((element) =>
                                                    element.title ==
                                                    task['catogery'])]
                                            .color,
                                        image: taskmodelList[taskmodelList
                                                .indexWhere((element) =>
                                                    element.title ==
                                                    task['catogery'])]
                                            .image,
                                        title: taskmodelList[taskmodelList
                                                .indexWhere((element) =>
                                                    element.title ==
                                                    task['catogery'])]
                                            .title,
                                        subtitle: taskmodelList[taskmodelList
                                                .indexWhere((element) =>
                                                    element.title ==
                                                    task['catogery'])]
                                            .subtitle,
                                        id: task['timestamp'],
                                        data: task['datatime'],
                                        time: task['timeOfDay'],
                                        isdone: task['done'],
                                        taskName: task['title'],
                                      ),
                                      taslength: totalTasks,
                                      index: index,
                                    ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Container(
                                  height: 60.0,
                                  color: index.isEven
                                      ? Colors.grey[200]
                                      : Colors.white,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        "$index:00",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                for (var task in data)
                                  if (parseTime(task['timeOfDay']).hour ==
                                      index)
                                    TaskInfoDataCard(
                                      taskModel: TaskModel(
                                        color: taskmodelList[taskmodelList
                                                .indexWhere((element) =>
                                                    element.title ==
                                                    task['catogery'])]
                                            .color,
                                        image: taskmodelList[taskmodelList
                                                .indexWhere((element) =>
                                                    element.title ==
                                                    task['catogery'])]
                                            .image,
                                        title: taskmodelList[taskmodelList
                                                .indexWhere((element) =>
                                                    element.title ==
                                                    task['catogery'])]
                                            .title,
                                        subtitle: taskmodelList[taskmodelList
                                                .indexWhere((element) =>
                                                    element.title ==
                                                    task['catogery'])]
                                            .subtitle,
                                        id: task['timestamp'],
                                        data: task['datatime'],
                                        time: task['timeOfDay'],
                                        isdone: task['done'],
                                        taskName: task['title'],
                                      ),
                                      taslength: totalTasks,
                                      index: index,
                                    ),
                              ],
                            );
                          }
                        },
                        childCount: 24,
                      ),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              future: _controller.getTasksBydata(dateTime),
            ),
          );
        },
      ),
    );
  }
}
