import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
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
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getDayName(DateTime.now()),
                                style: MangeStyles().getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                DateFormat("MMMM d").format(DateTime.now()),
                                style: MangeStyles().getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: totalTasks,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                onDismissed: (direction) {
                                  _controller
                                      .deleteTask(data[index]['timestamp']);
                                },
                                background: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 16),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      color: ColorManager.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                direction: DismissDirection.endToStart,
                                key: UniqueKey(),
                                child: NewTimeTask(
                                  taslength: totalTasks,
                                  index: index,
                                  taskModel: TaskModel(
                                    color: Color(
                                        data[index]['color'] ?? 0xffffffff),
                                    subtitle: "25 minute",
                                    id: data[index]['timestamp'],
                                    data: data[index]['datatime'],
                                    time: data[index]['timeOfDay'],
                                    isdone: data[index]['done'],
                                    taskName: data[index]['title'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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

  String getDayName(DateTime date) {
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return weekdays[date.weekday - 1];
  }
}

class NewTimeTask extends StatelessWidget {
  const NewTimeTask({
    super.key,
    required this.taskModel,
    required this.taslength,
    required this.index,
  });

  final TaskModel taskModel;
  final int taslength;
  final int index;
  @override
  Widget build(BuildContext context) {
    String timeString = taskModel.time!; // Replace with your actual time string
    int minutesToAdd = 25;

// Parse the time string
    List<String> timeParts = timeString.split(' ');
    String timeWithoutMeridiem = timeParts[0];
    String meridiem = timeParts[1];

    List<String> timeComponents = timeWithoutMeridiem.split(':');
    int hours = int.parse(timeComponents[0]);
    int minutes = int.parse(timeComponents[1]);

// Convert to 24-hour format if meridiem is 'pm'
    if (meridiem == 'pm' && hours != 12) {
      hours += 12;
    }

// Create a DateTime object with today's date and the adjusted time
    DateTime currentTime = DateTime.now();
    DateTime adjustedTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      hours,
      minutes,
    ).add(Duration(minutes: minutesToAdd));

    String time = (taskModel.time!.split(' ').first); // Output: 3:06 PM

    List<String> parts = time.split(':');
    int hoursk = int.parse(parts[0]);
    int minutesk = int.parse(parts[1]);

// Convert the hours to a 12-hour format
    int formattedHours = hoursk > 12 ? hoursk - 12 : hoursk;

// Determine if it's morning (AM) or afternoon/evening (PM)
    String period = hoursk >= 12 ? 'PM' : 'AM';

// Format the time
    String formattedTime = '$formattedHours:$minutesk $period';
    bool isLine = taslength - 1 == index;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: taskModel.color,
      ),
      child: Row(
        children: [
          Text(
            taskModel.taskName ?? "",
            style: MangeStyles().getBoldStyle(
              color: ColorManager.black,
              fontSize: FontSize.s17,
            ),
          ),
          Expanded(child: SizedBox()),
          Text(
            '$formattedTime - ${adjustedTime.hour}:${adjustedTime.minute} ',
            style: MangeStyles().getBoldStyle(
              color: ColorManager.black,
              fontSize: FontSize.s17,
            ),
          ),
        ],
      ),
    );
  }
}
