import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';

class StatisticController extends GetxController {
  List<FlSpot> spots = [];
  Future<List<Map<String, dynamic>>> retrieveTodayTasks() async {
    String userId = sharedPreferences.getString('id') ?? '';

    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);

    QuerySnapshot taskSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('datatime', isEqualTo: '${now.year}/${now.month}/${now.day}')
        // .where('done', isEqualTo: false)
        .orderBy(
          'timestamp',
          descending: false,
        )
        .get();

    List<Map<String, dynamic>> tasks = taskSnapshot.docs
        .map((DocumentSnapshot document) =>
            document.data() as Map<String, dynamic>)
        .toList();

    return tasks;
  }

  void getStatic() async {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = now.add(Duration(days: 7 - now.weekday));
    print('$startOfWeek -- $endOfWeek');
    QuerySnapshot taskSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences.getString('id'))
        .collection('tasks')
        .where('datatime',
            isGreaterThanOrEqualTo:
                '${startOfWeek.year}/${startOfWeek.month}/${startOfWeek.day}')
        .where('datatime',
            isLessThanOrEqualTo:
                '${endOfWeek.year}/${endOfWeek.month}/${endOfWeek.day}')
        .orderBy('datatime', descending: true)
        .get();

    // List<Map<String, dynamic>> tasks = taskSnapshot.docs
    //     .map((DocumentSnapshot document) =>
    //         document.data() as Map<String, dynamic>) FlSpot(0, 0),
    //     .toList();

    //     for (var element in tasks) {

    //     }
    // print(tasks);
  }

  @override
  void onInit() {
    getStatic();
    super.onInit();
  }
}
