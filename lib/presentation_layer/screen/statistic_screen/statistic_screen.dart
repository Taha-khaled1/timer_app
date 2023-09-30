import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/new_home_screen/new_home_screen.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/widget/CardPromoTimer.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/statistic_controller/statistic_controller.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/widget/chart.dart';
import 'package:task_manger/presentation_layer/screen/whatch_task_screen/whatch_task_screen.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const String _keyPrefix = 'user_activity_';
    DateTime dateTime = DateTime.now();
    final formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    final key = '$_keyPrefix$formattedDate';
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbarProfile(title: 'Statistics', isBack: false),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          final StatisticController _controller =
              Get.put(StatisticController());
          return SingleChildScrollView(
            child: Column(
              children: [
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
                        final data = snapshot.data;
                        // int totalTasks = data!.length;
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Summary",
                                      style: MangeStyles().getRegularStyle(
                                        color: ColorManager.black,
                                        fontSize: FontSize.s20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      HeaderContainer(
                                        title: 'Focus Time (min)',
                                        text: sharedPreferences
                                                .getInt("user_activity")
                                                .toString() ??
                                            '0',
                                      ),
                                      Expanded(child: SizedBox()),
                                      HeaderContainer(
                                        title: 'Total task',
                                        text: _controller.totalTasks,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Today",
                                      style: MangeStyles().getRegularStyle(
                                        color: ColorManager.black,
                                        fontSize: FontSize.s20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      HeaderContainer(
                                        title: 'Focus Time (min)',
                                        text: sharedPreferences
                                            .getInt(key)
                                            .toString(),
                                      ),
                                      Expanded(child: SizedBox()),
                                      HeaderContainer(
                                        title: 'Total task',
                                        text: _controller.todayTasks,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20),

                            Transform.translate(
                              offset: Offset(0, 0),
                              child: LineChartSample2(),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 15),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         DateFormat("'Today', MMMM d")
                            //             .format(DateTime.now()),
                            //         style: MangeStyles().getRegularStyle(
                            //           color: ColorManager.black,
                            //           fontSize: FontSize.s20,
                            //         ),
                            //         textAlign: TextAlign.center,
                            //       ),
                            //       TextButton(
                            //         onPressed: () {
                            //           // tabController.changeTabIndex(5);
                            //           Get.to(() => WhatchTaskScreen());
                            //         },
                            //         child: Text(
                            //           'See All',
                            //           style: MangeStyles().getBoldStyle(
                            //             color: ColorManager.kPrimary,
                            //             fontSize: FontSize.s20,
                            //           ),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   physics: NeverScrollableScrollPhysics(),
                            //   itemCount: data!.length,
                            //   itemBuilder: (context, index) {
                            //     return data[index]['done'] == true
                            // ? Dismissible(
                            //     onDismissed: (direction) {
                            //       _controller.deleteTask(
                            //           data[index]['timestamp']);
                            //     },
                            //     background: Container(
                            //       margin: EdgeInsets.symmetric(
                            //           horizontal: 15),
                            //       decoration: BoxDecoration(
                            //         color: Colors.redAccent,
                            //         borderRadius:
                            //             BorderRadius.circular(25),
                            //       ),
                            //       alignment: Alignment.centerRight,
                            //       padding: EdgeInsets.only(right: 16),
                            //       child: Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //           horizontal: 10,
                            //         ),
                            //         child: Icon(
                            //           Icons.delete,
                            //           color: ColorManager.white,
                            //           size: 30,
                            //         ),
                            //       ),
                            //     ),
                            //     direction: DismissDirection.endToStart,
                            //     key: UniqueKey(),
                            //             child: CardPromoTimer(
                            //               taskModel: TaskModel(
                            //                 color: Color(data[index]['color'] ??
                            //                     0xffffffff),
                            //                 subtitle: "25 minute",
                            //                 id: data[index]['timestamp'],
                            //                 data: data[index]['datatime'],
                            //                 time: data[index]['timeOfDay'],
                            //                 isdone: data[index]['done'],
                            //                 taskName: data[index]['title'],
                            //               ),
                            //               istowSubtitle: false,
                            //             ),
                            //           )
                            //         : SizedBox();
                            //   },
                            // ),
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
              ],
            ),
          );
        },
      ),
    );
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    super.key,
    required this.title,
    required this.text,
  });
  final String title, text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 180,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorManager.fillColor,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '$title\n',
          style: MangeStyles().getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s17,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '$text',
              style: MangeStyles().getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
