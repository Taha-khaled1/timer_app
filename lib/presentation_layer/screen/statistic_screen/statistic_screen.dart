import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/home_screen/widget/card_task.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/widget/CardPromoTimer.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/statistic_controller/statistic_controller.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/widget/chart.dart';
import 'package:task_manger/presentation_layer/screen/whatch_task_screen/whatch_task_screen.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbarProfile(title: 'Statistics'),
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
                        int totalTasks = data!.length;
                        return Column(
                          children: [
                            Transform.translate(
                              offset: Offset(0, 0),
                              child: LineChartSample2(),
                            ),
                            SizedBox(height: 50),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat("'Today', MMMM d")
                                        .format(DateTime.now()),
                                    style: MangeStyles().getRegularStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // tabController.changeTabIndex(5);
                                      Get.to(() => WhatchTaskScreen());
                                    },
                                    child: Text(
                                      'See All',
                                      style: MangeStyles().getBoldStyle(
                                        color: ColorManager.kPrimary,
                                        fontSize: FontSize.s20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                int ind = taskmodelList.indexWhere((element) =>
                                    element.title == data[index]['catogery']);
                                return Dismissible(
                                  onDismissed: (direction) {},
                                  background: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(right: 16),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        color: ColorManager.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  key: UniqueKey(),
                                  child: CardPromoTimer(
                                    taskModel: TaskModel(
                                      color: taskmodelList[ind].color,
                                      image: taskmodelList[ind].image,
                                      title: taskmodelList[ind].title,
                                      subtitle: taskmodelList[ind].subtitle,
                                      id: data[index]['timestamp'],
                                      data: data[index]['datatime'],
                                      time: data[index]['timeOfDay'],
                                      isdone: data[index]['done'],
                                    ),
                                    istowSubtitle: false,
                                  ),
                                );
                              },
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
              ],
            ),
          );
        },
      ),
    );
  }
}
