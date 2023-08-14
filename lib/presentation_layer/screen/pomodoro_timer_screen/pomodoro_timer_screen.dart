import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/screen/auth/info_account_screen/widget/custom_circle_Image.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/pomodoro_timer_controller/pomodoro_timer_controller.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/widget/CardPromoTimer.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/widget/CircularPomodoro.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/src/style_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class PomodoroTimerScreen extends StatelessWidget {
  const PomodoroTimerScreen({Key? key, required this.taskModel})
      : super(key: key);
  // final String image,name,
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    PomodoroTimerController pomodoroTimerController =
        Get.put(PomodoroTimerController());
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Pomodoro Timer'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                CardPromoTimer(
                  taskModel: taskModel,
                  istowSubtitle: true,
                ),
                SizedBox(
                  height: 350,
                  child: CircularPomodoro(taskModel: taskModel),
                ),
                GetBuilder<PomodoroTimerController>(
                  init: PomodoroTimerController(),
                  initState: (_) {},
                  builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (pomodoroTimerController.isplay)
                          CustomCircleImageAsset(
                            radius: 35,
                            image: 'assets/icons/replay.svg',
                            color: Color(0xFFF5F5F5),
                            onTap: () {
                              pomodoroTimerController.restartPomo();
                              pomodoroTimerController.changePlay(true);
                            },
                          ),
                        SizedBox(width: 15),
                        CustomCircleImageAsset(
                          radius: 50,
                          image: pomodoroTimerController.isplay == true
                              ? 'assets/icons/remus.svg'
                              : 'assets/icons/vidio.svg',
                          color: Color(0xFF7306FD),
                          onTap: () => pomodoroTimerController.playButton(),
                        ),
                        SizedBox(width: 15),
                        if (pomodoroTimerController.isplay)
                          CustomCircleImageAsset(
                            radius: 35,
                            image: 'assets/icons/stop.svg',
                            color: Color(0xFFF5F5F5),
                            onTap: () {
                              pomodoroTimerController.restartPomo();
                              pomodoroTimerController.changePlay(true);
                              pomodoroTimerController.pausePomo();
                              pomodoroTimerController.changePlay(false);
                            },
                          ),
                      ],
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
