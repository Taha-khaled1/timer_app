import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/home_screen/widget/card_task.dart';
import 'package:task_manger/presentation_layer/screen/whatch_task_screen/whatch_task_screen.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TabAppController tabController = Get.find();
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbarMain(),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: deviceInfo.localWidth * 0.05),
                    child: Text(
                      'Morning, Christina 👋',
                      style: MangeStyles().getBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s30 + 2,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'The only time you fail is when you fall down and stay down',
                  style: MangeStyles().getRegularStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Container(
                  width: deviceInfo.localWidth * 0.94,
                  height: 160,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
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
                    children: [
                      CircularPercentIndicator(
                        backgroundColor: ColorManager.grey2,
                        radius: 60.0,
                        lineWidth: 15.0,
                        percent: 0.75,
                        progressColor: ColorManager.kPrimary,
                        center: Text(
                          "75%",
                          style: MangeStyles().getRegularStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s20,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Wow! Your daily goals \n is almost done!",
                              style: MangeStyles().getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            '12 of 16 completed!',
                            style: MangeStyles().getRegularStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today Tasks (16)',
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
                  itemCount: taskmodelList.length,
                  itemBuilder: (context, index) {
                    return CardTask(
                      taskModel: taskmodelList[index],
                    );
                  },
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
