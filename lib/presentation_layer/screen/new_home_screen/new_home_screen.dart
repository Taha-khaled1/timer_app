import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/new_home_screen/new_home_controller.dart';
import 'package:task_manger/presentation_layer/screen/new_home_screen/widget/HeaderUi.dart';
import 'package:task_manger/presentation_layer/screen/new_home_screen/widget/new_card_task.dart';
import 'package:task_manger/presentation_layer/screen/new_home_screen/widget/task_showBottomSheet.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class NewHomeScreen extends StatefulWidget {
  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  bool isfliterdone = false;
  bool deleteload = false;
  @override
  Widget build(BuildContext context) {
    final NewHomeController _controller = Get.put(NewHomeController());

    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppbarProfile(),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: deviceInfo.localWidth * 0.05),
                      child: Text(
                        'Start where you are, use what you have, do what you can.',
                        style: MangeStyles().getRegularStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s30,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                  builder: (ctx, snapshot) {
                    // Checking if future is resolved or not
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: TextStyle(fontSize: 18),
                          ),
                        );

                        // if we got our data
                      } else if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        final data = snapshot.data;
                        int totalTasks = data!.length;
                        int completedTasks =
                            data.where((task) => task['done'] == true).length;

                        double completionPercentage =
                            (completedTasks / totalTasks) * 100;
                        print('---------> $completionPercentage');
                        return Column(
                          children: [
                            Text(
                              'The number of active users ${_controller.totalusers ?? 1}',
                              style: MangeStyles().getRegularStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final bool? status = await FlutterOverlayWindow
                                    .requestPermission();
                                print(status);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xff0FB9B1),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 30,
                                      offset: Offset(
                                        0,
                                        5,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'START',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {},
                              child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xff0FB9B1),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 30,
                                      offset: Offset(
                                        0,
                                        5,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'START',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final bool status = await FlutterOverlayWindow
                                    .isPermissionGranted();
                                if (status) {
                                  print(WindowSize.matchParent);
                                  await FlutterOverlayWindow.showOverlay(
                                    enableDrag: false,
                                    overlayTitle: "X-SLAYER",
                                    overlayContent: 'Overlay Enabled',
                                    flag: OverlayFlag.defaultFlag,
                                    visibility:
                                        NotificationVisibility.visibilityPublic,
                                    positionGravity: PositionGravity.auto,
                                    height: 1200,
                                    width: 900,
                                  );
                                  print("FlutterOverlayWindow");
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 200,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xff0FB9B1),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 30,
                                      offset: Offset(
                                        0,
                                        5,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'START',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onVerticalDragUpdate: (details) {
                                if (details.delta.dy < 0) {
                                  // Check if the drag direction is upwards
                                  customtaskShowBottomSheet(context);
                                }
                              },
                              onVerticalDragDown: (details) {
                                // This captures the drag gesture so that it doesn't propagate to parent widgets
                                // GestureBinding.instance.gestureArena.add(details.localPosition);
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/hamburger.png",
                                      width: 25,
                                      height: 25,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  HeaderUi(
                                    onTap: () {
                                      setState(() {
                                        isfliterdone = true;
                                        print(isfliterdone);
                                      });
                                    },
                                    onTap2: () {
                                      setState(() {
                                        isfliterdone = false;
                                        print(isfliterdone);
                                      });
                                      print(isfliterdone);
                                    },
                                  ),
                                  SizedBox(
                                    height: 218,
                                    // width: 140,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // shrinkWrap: true,
                                      // physics: NeverScrollableScrollPhysics(),
                                      // data.length > 3 ? 3 :
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return data[index]['done'] &&
                                                isfliterdone
                                            ? SizedBox()
                                            : !deleteload
                                                ? NewCardTask(
                                                    onTap: () async {
                                                      setState(() {
                                                        deleteload = true;
                                                      });
                                                      await _controller
                                                          .deleteTask(data[
                                                                  index]
                                                              ['timestamp']);
                                                      setState(() {
                                                        deleteload = false;
                                                      });
                                                    },
                                                    taskModel: TaskModel(
                                                      color: Color(data[index]
                                                              ['color'] ??
                                                          0xffffffff),
                                                      subtitle: "25 minute",
                                                      id: data[index]
                                                          ['timestamp'],
                                                      pomotime: data[index]
                                                          ['pomotime'],
                                                      data: data[index]
                                                          ['datatime'],
                                                      time: data[index]
                                                          ['timeOfDay'],
                                                      isdone: data[index]
                                                          ['done'],
                                                      taskName: data[index]
                                                          ['title'],
                                                      workSessions: data[index]
                                                          ['workSessions'],
                                                      longBreak: data[index]
                                                          ['longBreak'],
                                                      shortBreak: data[index]
                                                          ['shortBreak'],
                                                    ),
                                                  )
                                                : SizedBox();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    }

                    // Displaying LoadingSpinner to indicate waiting state
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },

                  // Future that needs to be resolved
                  // inorder to display something on the Canvas
                  future: _controller.retrieveTodayTasks(),
                ),
                SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}
