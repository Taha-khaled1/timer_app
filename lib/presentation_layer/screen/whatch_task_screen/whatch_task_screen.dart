import 'package:flutter/material.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/screen/home_screen/widget/card_task.dart';
import 'package:task_manger/presentation_layer/src/components_packge.dart';

class WhatchTaskScreen extends StatelessWidget {
  const WhatchTaskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Today Tasks (16)'),
      body: ListView.builder(
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: taskmodelList.length,
        itemBuilder: (context, index) {
          return CardTask(
            taskModel: taskmodelList[index],
          );
        },
      ),
    );
  }
}
