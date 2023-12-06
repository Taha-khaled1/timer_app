import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/screen/auth/info_account_screen/widget/custom_circle_Image.dart';
import 'package:task_manger/presentation_layer/screen/create_task_screen/create_task_screen.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/pomodoro_timer_controller/pomodoro_timer_controller.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/widget/CardPromoTimer.dart';
import 'package:task_manger/presentation_layer/screen/sound_screen/sound_screen.dart';
import 'package:task_manger/presentation_layer/screen/succss_screen.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/src/style_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class PomodoroTimerScreen extends StatefulWidget {
  const PomodoroTimerScreen({Key? key, required this.taskModel})
      : super(key: key);
  // final String image,name,
  final TaskModel taskModel;

  @override
  State<PomodoroTimerScreen> createState() => _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends State<PomodoroTimerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PomodoroTimerController pomodoroTimerController =
        Get.put(PomodoroTimerController(widget.taskModel));
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
                GetBuilder<PomodoroTimerController>(
                  builder: (controller) {
                    return InkWell(
                      onTap: () {
                        pomodoroTimerController.stopWatchTimer!.onAddLap();
                      },
                      child: CardPromoTimer(
                        taskModel: widget.taskModel,
                        istowSubtitle: true,
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      GetBuilder<PomodoroTimerController>(
                        builder: (controller) {
                          return pomodoroTimerController.stopWatchTimer == null
                              ? Center(child: CircularProgressIndicator())
                              : Center(
                                  child: SizedBox(
                                    height: 350,
                                    child: StreamBuilder<int>(
                                      stream: pomodoroTimerController
                                          .stopWatchTimer!.rawTime,
                                      initialData: pomodoroTimerController
                                          .stopWatchTimer!.rawTime.value,
                                      builder: (context, snap) {
                                        final value = snap.data!;
                                        final displayTime =
                                            StopWatchTimer.getDisplayTime(
                                          value,
                                          hours: true,
                                          milliSecond: false,
                                        );
                                        final parts = displayTime.split(':');
                                        final hours = parts[0];
                                        final minutes = parts[1];
                                        final seconds = parts[2];
                                        final totalDuration = Duration(
                                          seconds: controller.duration,
                                        ); // Example duration of a Pomodoro

                                        final remainingTime =
                                            totalDuration.inMilliseconds -
                                                value;
                                        final completedPercentage = 1.0 -
                                            (remainingTime /
                                                totalDuration.inMilliseconds);
                                        // .clamp(0.0, 1.0);
                                        print(
                                            "totalDuration : ${totalDuration.inMilliseconds} value : ${value}  completedPercentage : $completedPercentage  === ${totalDuration.inMilliseconds - value}");
                                        return SizedBox(
                                          child: CircularPercentIndicator(
                                            backgroundColor:
                                                ColorManager.kPrimary,
                                            radius: 120.0,
                                            lineWidth: 20.0,
                                            percent: completedPercentage,
                                            center: TimeDisplay(
                                              hours: hours,
                                              minutes: minutes,
                                              seconds: seconds,
                                            ),
                                            progressColor: ColorManager.grey2,
                                          ),
                                        );

                                        // TimeDisplay(
                                        //   hours: hours,
                                        //   minutes: minutes,
                                        //   seconds: seconds,
                                        // );
                                      },
                                    ),
                                    // child: CircularPomodoro(taskModel: taskModel),
                                  ),
                                );
                        },
                      ),
                      Positioned(
                        right: 0,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => CreateTaskScreen(), arguments: {
                                  "taskModel": widget.taskModel,
                                });
                              },
                              child: Image.asset(
                                "assets/icons/image 8.png",
                                // color: Colors.black,
                                width: 45,
                                height: 50,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SoundScreen());
                              },
                              child: Image.asset(
                                "assets/icons/image 9.png",
                                // color: Colors.black,
                                width: 45,
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                GetBuilder<PomodoroTimerController>(
                  init: PomodoroTimerController(widget.taskModel),
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

void showAlert(TaskModel taskModel) {
  PomodoroTimerController controller = Get.find();
  int breakis = 0;
  Duration? timeDuration;
  Get.dialog(
    barrierDismissible: false,
    Dialog(
      child: InfoWidget(
        builder: (context, deviceInfo) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min, // Use minimum space vertically
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Take a break",
                    style: MangeStyles().getBoldStyle(
                      color: ColorManager.kPrimary,
                      fontSize: FontSize.s25,
                    ),
                  ),
                ),
                // Line
                Divider(),
                // Emotion (I'm using an emoji as an example)
                SizedBox(),
                // Image.asset("name"),
                if (breakis != 0) ProgressExample(timeDuration: timeDuration!),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "just relax and continue to work after a break",
                    style: MangeStyles().getBoldStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ),
                if (breakis == 0)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        width: deviceInfo.localWidth * 0.42,
                        haigh: 50,
                        color: ColorManager.kPrimary3,
                        text: "Short break",
                        fontSize: 16,
                        press: () {
                          timeDuration =
                              Duration(minutes: taskModel.shortBreak!);
                          setState(() {
                            breakis = 1;
                          });
                        },
                      ),
                      CustomButton(
                        width: deviceInfo.localWidth * 0.42,
                        haigh: 50,
                        color: ColorManager.kPrimary3,
                        fontSize: 16,
                        text: "Long break",
                        press: () {
                          timeDuration =
                              Duration(minutes: taskModel.longBreak!);
                          setState(() {
                            breakis = 2;
                          });
                        },
                      ),
                    ],
                  ),
                CustomButton(
                  width: 160,
                  haigh: 45,
                  color: ColorManager.kPrimary3,
                  text: "continue",
                  press: () async {
                    if (controller.endWork >= taskModel.workSessions!) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(sharedPreferences.getString('id'))
                          .collection('tasks')
                          .doc(taskModel.id)
                          .update({
                        'done': true,
                      });
                      Get.to(() => SuccssScreen());
                    } else {
                      controller.endWork++;
                      controller.restartPomo();
                      Get.back();
                      controller.changeupdate();
                    }
                  },
                ),
              ],
            );
          });
        },
      ),
    ),
  );
}

class ProgressExample extends StatefulWidget {
  final Duration timeDuration;

  const ProgressExample({super.key, required this.timeDuration});
  @override
  _ProgressExampleState createState() => _ProgressExampleState();
}

class _ProgressExampleState extends State<ProgressExample> {
  late Timer _timer;
  late Duration _timeDuration;
  double _progress = 0;
  Duration _elapsedTime = Duration();

  @override
  void initState() {
    _timeDuration = widget.timeDuration;
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_elapsedTime < _timeDuration) {
        setState(() {
          _elapsedTime += Duration(seconds: 1);
          _progress = _elapsedTime.inSeconds / _timeDuration.inSeconds;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                  '${_elapsedTime.inMinutes}:${_elapsedTime.inSeconds % 60} / ${_timeDuration.inMinutes.toString()}:00'),
            ),
            SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 10,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                backgroundColor: Colors.grey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeDisplay extends StatelessWidget {
  final String hours;
  final String minutes;
  final String seconds;

  TimeDisplay(
      {required this.hours, required this.minutes, required this.seconds});

  Widget _timeBlock(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      height: 50,
      // decoration: BoxDecoration(
      //   color: ColorManager.background,
      //   borderRadius: BorderRadius.circular(20),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.2),
      //       spreadRadius: 5,
      //       blurRadius: 7,
      //       offset: Offset(0, 3),
      //     ),
      //   ],
      // ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _timeBlock(hours, "HOURS"),
          // VerticalDivider(color: Colors.grey[300], thickness: 1.5),
          _timeBlock(minutes, "MINUTES"),
          VerticalDivider(color: Colors.grey[300], thickness: 1.5),
          _timeBlock(seconds, "SECONDS"),
        ],
      ),
    );
  }
}
