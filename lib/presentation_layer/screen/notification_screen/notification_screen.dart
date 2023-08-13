import 'package:flutter/material.dart';
import 'package:task_manger/data_layer/models/notf_model.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

import 'widget/NotificationCard.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbarProfile(title: 'Today Tasks (16)'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return ListView.builder(
            itemCount: notfModelList.length,
            itemBuilder: (BuildContext context, int index) {
              return NotificationCard(
                notfModel: notfModelList[index],
              );
            },
          );
        },
      ),
    );
  }
}
