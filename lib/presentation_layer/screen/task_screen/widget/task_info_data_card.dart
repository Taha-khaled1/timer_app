import 'package:flutter/material.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';

class TaskInfoDataCard extends StatelessWidget {
  const TaskInfoDataCard({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;
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
    return Container(
      width: 380,
      height: 90,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              taskModel.time!,
              style: MangeStyles().getBoldStyle(
                color: Color(0xFF424242),
                fontSize: FontSize.s16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 90,
              padding: const EdgeInsets.only(
                top: 20,
                left: 24,
                right: 16,
                bottom: 20,
              ),
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.96, 0.28),
                  end: Alignment(0.96, -0.28),
                  colors: [Color(0xFF7306FD), Color(0xFFB173FF)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              taskModel.taskName ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                                height: 1.20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              '${taskModel.time!} - ${adjustedTime.hour}:${adjustedTime.minute} ',
                              style: TextStyle(
                                color: Color(0xFFEEEEEE),
                                fontSize: 14,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                                letterSpacing: 0.20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
