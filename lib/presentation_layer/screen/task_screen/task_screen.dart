import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/screen/task_screen/widget/task_info_data_card.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  EasyDateTimeLine(
                    initialDate: DateTime.now(),
                    onDateChange: (selectedDate) {
                      //[selectedDate] the new date selected.
                    },
                    dayProps: const EasyDayProps(
                      inactiveDayDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xFFF5F5F5),
                      ),
                      activeDayDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                          begin: Alignment(0.96, -0.28),
                          end: Alignment(-0.96, 0.28),
                          colors: [Color(0xFF7306FD), Color(0xFFB173FF)],
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
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskInfoDataCard();
                    },
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
