import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/utils/shard_function/convert-time.dart';

class StatisticController extends GetxController {
  List<FlSpot> spotsController = [];
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
    await getStatic();
    return tasks;
  }

  Future<void> getStatic() async {
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: 7 - now.weekday));
    DateTime endOfWeek = now.add(Duration(days: now.weekday - 1));
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

    // Initialize a Map to hold counts for each day of the week.
    Map<int, double> weeklyCounts = {
      for (var i = 0; i < 7; i++) i: 0.0,
    };

    for (var element in taskSnapshot.docs) {
      // print('---');
      DateTime? taskDate;
      Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('datatime')) {
        // print('###');
        try {
          String timeString = '${data['timeOfDay']}';
          String dateString = '${data['datatime']}';
          taskDate = await convertTDataTime(timeString, dateString);

          // print('parsing date: ${data['datatime'].toString()}');
        } catch (e) {
          print('Error parsing date: ${data['datatime'].toString()}');
          continue; // Skip to the next iteration if there's an error.
        }

        int diff = taskDate.difference(startOfWeek).inDays;
        if (weeklyCounts.containsKey(diff)) {
          // print('%%%');
          weeklyCounts[diff] = (weeklyCounts[diff] ?? 0) + 1;
        }
      }
    }

    // Convert the Map to FlSpot list
    List<FlSpot> spots = [];
    int y = 0;
    weeklyCounts.forEach((key, value) {
      print('key : $key value:$value');
      spots.add(FlSpot(key.toDouble(), value));
    });

    // Assuming you have a controller or state variable to update with spots
    spotsController.addAll(spots);
    print('enndddddddddddddd');
  }

  @override
  void onInit() {
    // getStatic();
    super.onInit();
  }
}
