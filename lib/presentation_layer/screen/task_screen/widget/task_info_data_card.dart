import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';

import 'line.dart';

class TaskInfoDataCard extends StatefulWidget {
  const TaskInfoDataCard({
    super.key,
    required this.taskModel,
    required this.taslength,
    required this.index,
  });
  final TaskModel taskModel;
  final int taslength;
  final int index;

  @override
  State<TaskInfoDataCard> createState() => _TaskInfoDataCardState();
}

class _TaskInfoDataCardState extends State<TaskInfoDataCard> {
  @override
  Widget build(BuildContext context) {
    String timeString =
        widget.taskModel.time!; // Replace with your actual time string
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

    String time = (widget.taskModel.time!.split(' ').first); // Output: 3:06 PM

    List<String> parts = time.split(':');
    int hoursk = int.parse(parts[0]);
    int minutesk = int.parse(parts[1]);

// Convert the hours to a 12-hour format
    int formattedHours = hoursk > 12 ? hoursk - 12 : hoursk;

// Determine if it's morning (AM) or afternoon/evening (PM)
    String period = hoursk >= 12 ? 'PM' : 'AM';

// Format the time
    String formattedTime = '$formattedHours:$minutesk $period';
    bool isLine = widget.taslength - 1 == widget.index;
    return Container(
      width: 380,
      height: isLine ? 144 : 90,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  formattedTime,
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
                                  widget.taskModel.taskName ?? '',
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
                              GestureDetector(
                                onTap: () {
                                  print('${widget.taskModel.time!}');
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    '$formattedTime - ${adjustedTime.hour}:${adjustedTime.minute} ',
                                    style: TextStyle(
                                      color: Color(0xFFEEEEEE),
                                      fontSize: 14,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w800,
                                      height: 1.40,
                                      letterSpacing: 0.20,
                                    ),
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
          if (isLine) SliderLine(),
        ],
      ),
    );
  }
}

class SliderLine extends StatefulWidget {
  const SliderLine({
    super.key,
  });

  @override
  State<SliderLine> createState() => _SliderLineState();
}

class _SliderLineState extends State<SliderLine> {
  double sliderValue3 = double.parse(getCurrentTime().split(':').first);
  @override
  Widget build(BuildContext context) {
    print("--> ${int.parse(getCurrentTime().split(':').first)}");
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: SfSlider(
        min: 1.0,
        max: 24.0,
        activeColor: ColorManager.kPrimary,
        inactiveColor: ColorManager.grey2,
        value: sliderValue3.toInt(),
        interval: 24,
        showTicks: false,
        showLabels: false,
        enableTooltip: true,
        minorTicksPerInterval: 0,
        thumbShape: SfThumbShape(),
        tooltipTextFormatterCallback: (dynamic value, String formattedText) {
          return getCurrentTimeD();
        },
        onChanged: (dynamic value) {},
      ),
    );
  }
}

class CustomLine extends StatefulWidget {
  const CustomLine({super.key});

  @override
  State<CustomLine> createState() => _CustomLineState();
}

class _CustomLineState extends State<CustomLine> {
  bool showSlider = false;
  double sliderValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 15,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 6,
            child: Container(
              width: 380,
              height: 4,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.96, 0.28),
                  end: Alignment(0.96, -0.28),
                  colors: [Color(0xFF7306FD), Color(0xFFB173FF)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(
                  side: BorderSide(width: 2, color: Color(0xFF7306FD)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String getCurrentTime() {
  DateTime now = DateTime.now();
  String formattedTime = DateFormat.Hm().format(now);
  print("as-> $formattedTime");
  return formattedTime;
}

String getCurrentTimeD() {
  DateTime now = DateTime.now();
  String formattedTime = DateFormat.jm().format(now);
  return formattedTime;
}
