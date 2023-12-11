import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/statistic_controller/statistic_controller.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/widget/BarChartWidget.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/widget/HeaderContainer.dart';
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
      appBar: AppbarProfile(title: 'Statistics', isBack: false),
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
                                        text:
                                            "${sharedPreferences.getInt("user_activity") ?? 0}",
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
                                        text:
                                            "${sharedPreferences.getInt(key) ?? 0}",
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Focus Time",
                                style: MangeStyles().getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 400, child: TabBarViewWidget()),
                          ],
                        );
                      }
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
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

class TabBarViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 10,
          // backgroundColor: Colors.blueGrey.shade500,
          // title: Text('TabBar Widget'),
          bottom: TabBar(
            indicatorColor: Colors.lime,
            indicatorWeight: 5.0,
            labelColor: Colors.black,
            labelPadding: EdgeInsets.only(top: 10.0),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Recent Days',
                // icon: Icon(
                //   Icons.cake,
                //   color: Colors.white,
                // ),
                // iconMargin: EdgeInsets.only(bottom: 10.0),
              ),
              Tab(
                text: 'Recent Weeks',
                // icon: Icon(
                //   Icons.radio,
                //   color: Colors.white,
                // ),
                // iconMargin: EdgeInsets.only(bottom: 10.0),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content for Tab 1
            SizedBox(height: 400, child: BarChartWidget()),
            // Content for Tab 2
            SizedBox(height: 400, child: BarChartWidget()),
          ],
        ),
      ),
    );
  }
}
