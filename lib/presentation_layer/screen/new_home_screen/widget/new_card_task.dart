import 'package:flutter/material.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/pomodoro_timer_screen.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';
import 'package:task_manger/presentation_layer/utils/sub_string/sub_string.dart';

class NewCardTask extends StatelessWidget {
  const NewCardTask({
    super.key,
    required this.taskModel,
    required this.onTap,
  });
  final void Function()? onTap;
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    String timeString = taskModel.time!; // Replace with your actual time string
    int minutesToAdd = taskModel.pomotime!;

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

// Format the time
    String formattedTime = '$formattedHours:$minutesk';
    return GestureDetector(
      onTap: () {
        if (taskModel.isdone! == false) {
          Get.to(
            () => PomodoroTimerScreen(
              taskModel: taskModel,
            ),
          );
        } else {
          showToast('The task has been completed successfully');
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 5, right: 5),
        width: 138,
        height: 100,
        decoration: BoxDecoration(
          color: taskModel.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Transform.translate(
                offset: Offset(0, -8),
                child: GestureDetector(
                  onTap: onTap,
                  child: CircleAvatar(
                    backgroundColor: ColorManager.grey2,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),

            CircleAvatar(
              backgroundColor: ColorManager.grey2.withOpacity(0.4),
              radius: 50,
              child: !taskModel.isdone!
                  ? Text(
                      "${taskModel.pomotime}' ",
                      style: MangeStyles().getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 40,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 65,
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              subString(taskModel.taskName ?? "", 10),
              style: MangeStyles().getBoldStyle(
                color: ColorManager.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '$formattedTime - ${adjustedTime.hour}:${adjustedTime.minute} ',
              style: MangeStyles().getBoldStyle(
                color: ColorManager.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
