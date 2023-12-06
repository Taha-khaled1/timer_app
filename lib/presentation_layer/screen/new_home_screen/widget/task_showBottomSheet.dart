import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/new_home_screen/new_home_controller.dart';
import 'package:task_manger/presentation_layer/screen/new_home_screen/new_home_screen.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'new_card_task.dart';

customtaskShowBottomSheet(BuildContext context) {
  final NewHomeController _controller = Get.put(NewHomeController());
  bool isfliterdone = false;

  showModalBottomSheet(
    backgroundColor: ColorManager.background,
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    )),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            // padding: EdgeInsets.all(16.0),
            child: InfoWidget(
              builder: (context, deviceInfo) {
                return SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            if (details.delta.dy < 0) {
                              // Check if the drag direction is upwards
                              Get.back();
                            }
                          },
                          onVerticalDragDown: (details) {
                            Get.back();
                            // This captures the drag gesture so that it doesn't propagate to parent widgets
                            // GestureBinding.instance.gestureArena.add(details.localPosition);
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/hamburger.png",
                              width: 25,
                              height: 25,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                      HeaderUi(
                        onTap: () {
                          // setState(() {
                          isfliterdone = true;
                          print("================");
                          setState(
                            () {},
                          );
                          // print(isfliterdone);
                          // });
                        },
                        onTap2: () {
                          print("VVVVVVVVVVVVVVVVVVVV");
                          isfliterdone = false;
                          setState(
                            () {},
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      FutureBuilder(
                        builder: (ctx, snapshot) {
                          // Checking if future is resolved or not
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
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

                              return SizedBox(
                                height: 500,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 6 / 10.5,
                                  ),
                                  itemCount: data?.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return Container(
                                      width: 140,
                                      height: 200,
                                      margin: EdgeInsets.only(bottom: 10),
                                      // color: Colors.black,
                                      child: NewCardTask(
                                        onTap: () async {
                                          await _controller
                                              .deleteTask(data[i]['timestamp']);
                                          Get.to(() => MainScreen());
                                          // setState(() {});
                                        },
                                        taskModel: TaskModel(
                                          color: Color(
                                              data![i]['color'] ?? 0xffffffff),
                                          subtitle: "25 minute",
                                          id: data![i]['timestamp'],
                                          pomotime: data[i]['pomotime'],
                                          data: data[i]['datatime'],
                                          time: data[i]['timeOfDay'],
                                          isdone: data[i]['done'],
                                          taskName: data[i]['title'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );

                              // Wrap(
                              //   alignment: WrapAlignment.start,
                              //   runAlignment: WrapAlignment.start,
                              //   direction: Axis.horizontal,
                              //   crossAxisAlignment: WrapCrossAlignment.start,
                              //   // direction: Axis.horizontal,
                              //   children: [
                              //     for (int i = 0; i < data!.length; i++)
                              //       data[i]['done'] && isfliterdone
                              //           ? SizedBox()
                              //           : Container(
                              //               width: 140,
                              //               height: 200,
                              //               margin: EdgeInsets.only(bottom: 10),
                              //               // color: Colors.black,
                              //               child: NewCardTask(
                              //                 onTap: () async {
                              //                   await _controller.deleteTask(
                              //                       data[i]['timestamp']);
                              //                   Get.to(() => MainScreen());
                              //                   // setState(() {});
                              //                 },
                              //                 taskModel: TaskModel(
                              //                   color: Color(data[i]['color'] ??
                              //                       0xffffffff),
                              //                   subtitle: "25 minute",
                              //                   id: data![i]['timestamp'],
                              //                   pomotime: data[i]['pomotime'],
                              //                   data: data[i]['datatime'],
                              //                   time: data[i]['timeOfDay'],
                              //                   isdone: data[i]['done'],
                              //                   taskName: data[i]['title'],
                              //                 ),
                              //               ),
                              //             ),
                              //   ],
                              // );
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
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}
