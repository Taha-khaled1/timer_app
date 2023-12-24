import 'package:flutter/material.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/pomodoro_timer_screen.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';

class CardTask extends StatelessWidget {
  const CardTask({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
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
        width: 380,
        height: 120,
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 24,
          bottom: 20,
        ),
        margin: EdgeInsets.only(top: 15, right: 10, left: 10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0C04060F),
              blurRadius: 60,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: taskModel.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.taskName ?? '',
                    style: MangeStyles().getRegularStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: FontSize.s20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 7),
                  Text(
                    '25 minutes',
                    style: MangeStyles().getRegularStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: FontSize.s14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 44,
              height: 44,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.96, 0.28),
                  end: Alignment(0.96, -0.28),
                  colors: [Color(0xFF1AB65C), Color(0xFF39E180)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Icon(
                taskModel.isdone! ? Icons.done : Icons.play_arrow,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
