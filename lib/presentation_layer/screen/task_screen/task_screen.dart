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

  DateTime selectedDate = DateTime.now();

  // This function is triggered when the date widget is tapped
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000, 1),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final TaskController _controller = Get.put(TaskController());
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppbarProfile(title: 'Pomodoro Task'),
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
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('EEEE').format(selectedDate),
                                  style: MangeStyles().getRegularStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  DateFormat('yMMMM').format(selectedDate),
                                  style: MangeStyles().getRegularStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // DateWidget(),
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
              future: _controller.getTasksBydata(selectedDate),
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

class DateWidget extends StatefulWidget {
  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  DateTime selectedDate = DateTime.now();

  // This function is triggered when the date widget is tapped
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000, 1),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: <Widget>[
            Text(
              "${selectedDate.toLocal()}"
                  .split(' ')[0], // Displays the selected date
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat('EEEE')
                  .format(selectedDate), // Displays the name of the day
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat('yMMMM')
                  .format(selectedDate), // Displays year and month
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
