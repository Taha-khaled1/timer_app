import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/screen/home_screen/home_controller.dart';
import 'package:task_manger/presentation_layer/screen/home_screen/widget/card_task.dart';
import 'package:task_manger/presentation_layer/src/components_packge.dart';

class WhatchTaskScreen extends StatelessWidget {
  const WhatchTaskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Today Tasks'),
      body: FutureBuilder(
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

              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return CardTask(
                        taskModel: TaskModel(
                          color: Color(data[index]['color'] ?? 0xffffffff),
                          subtitle: "25 minute",
                          id: data[index]['timestamp'],
                          data: data[index]['datatime'],
                          time: data[index]['timeOfDay'],
                          isdone: data[index]['done'],
                          taskName: data[index]['title'],
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
    );
  }
}
