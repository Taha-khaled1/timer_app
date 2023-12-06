import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/widget/CircularPomodoro.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/widget/BarChartWidget.dart';

class StatisticController extends GetxController {
  List<String> weeknams = [
    'Th',
    'Fr',
    'Sa',
    'Su',
    'Mo',
    'Tu',
    'We',
  ];
  List<FlSpot> spotsController = [];
  String todayTasks = "";
  String totalTasks = "";
  Future<List<Map<String, dynamic>>> retrieveTodayTasks() async {
    String userId = sharedPreferences.getString('id') ?? '';
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
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
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    List<Map<String, dynamic>> tasks = taskSnapshot.docs
        .map((DocumentSnapshot document) =>
            document.data() as Map<String, dynamic>)
        .toList();
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@${tasks.length}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    await getStatic();
    todayTasks = await todayTaskTotal();
    totalTasks = await TaskTotal();
    return tasks;
  }

  Future<void> deleteTask(id) async {
    String userId = sharedPreferences.getString('id') ?? '';
    var taskSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(id)
        .delete();
  }

  Future<String> TaskTotal() async {
    QuerySnapshot totalTaskSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences.getString('id'))
        .collection('tasks')
        .get();

    return totalTaskSnapshot.docs.length.toString();
  }

  Future<String> todayTaskTotal() async {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay =
        startOfDay.add(Duration(days: 1)).subtract(Duration(seconds: 1));

// Convert DateTime objects to string in 'yyyy/M/dd' format
    String startOfDayString =
        '${startOfDay.year}/${startOfDay.month}/${startOfDay.day}';
    String endOfDayString =
        '${endOfDay.year}/${endOfDay.month}/${endOfDay.day}';

    QuerySnapshot todayTaskSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences.getString('id'))
        .collection('tasks')
        .where('datatime', isGreaterThanOrEqualTo: startOfDayString)
        .where('datatime', isLessThanOrEqualTo: endOfDayString)
        .get();

    return todayTaskSnapshot.docs.length.toString();
  }

  List<ChartData> spots = [];
  Future<void> getStatic() async {
    spots.clear();
    List<int> x = await calculateWeeklyStatistics();
    for (int y = 0; y < x.length; y++) {
      spots.add(ChartData(weeknams[y], x[y].toDouble()));
    }
    // int i = 0;
    // for (var element in x) {
    //   print('$i -->  value : $element');
    //   i++;
    // }
    // print(
    //     '!!!!!!!!!!!!!!!!!    ${calculateWeeklyStatistics()}!!!!!!!!!!!!!!!!');
    // DateTime now = DateTime.now();
    // DateTime startOfWeek = now.subtract(Duration(days: 7 - now.weekday));
    // DateTime endOfWeek = now.add(Duration(days: now.weekday - 1));
    // print('$startOfWeek -- $endOfWeek');
    // QuerySnapshot taskSnapshot = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(sharedPreferences.getString('id'))
    //     .collection('tasks')
    //     .where('datatime',
    //         isGreaterThanOrEqualTo:
    //             '${startOfWeek.year}/${startOfWeek.month}/${startOfWeek.day}')
    //     .where('datatime',
    //         isLessThanOrEqualTo:
    //             '${endOfWeek.year}/${endOfWeek.month}/${endOfWeek.day}')
    //     .orderBy('datatime', descending: true)
    //     .get();

    // Initialize a Map to hold counts for each day of the week.
    Map<int, double> weeklyCounts = {
      for (var i = 0; i < 7; i++) i: 0.0,
    };

    // for (var element in taskSnapshot.docs) {
    //   // print('---');
    //   DateTime? taskDate;
    //   Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
    //   if (data != null && data.containsKey('datatime')) {
    //     // print('###');
    //     try {
    //       String timeString = '${data['timeOfDay']}';
    //       String dateString = '${data['datatime']}';
    //       taskDate = await convertTDataTime(timeString, dateString);

    //       // print('parsing date: ${data['datatime'].toString()}');
    //     } catch (e) {
    //       print('Error parsing date: ${data['datatime'].toString()}');
    //       continue; // Skip to the next iteration if there's an error.
    //     }

    //     int diff = taskDate.difference(startOfWeek).inDays;
    //     if (weeklyCounts.containsKey(diff)) {
    //       // print('%%%');
    //       weeklyCounts[diff] = (weeklyCounts[diff] ?? 0) + 1;
    //     }
    //   }
    // }

    // Convert the Map to FlSpot list
    // List<FlSpot> spots = [];
    // int y = 0;
    // weeklyCounts.forEach((key, value) {
    //   print('key : $key value:$value');
    //   spots.add(FlSpot(key.toDouble(), value));
    // });

    // spots[0].value = 5;
    // spots[1].value = 8;
    // spots[2].value = 6;
    // int y = 0;
    // weeklyCounts.forEach((key, value) {
    //   print('key : $key value:$value');
    //   spots.add(ChartData(key.toString(), value));
    // });
    // Assuming you have a controller or state variable to update with spots
    // spotsController.addAll(spots);
    // print('enndddddddddddddd');
  }

  Future<List<int>> calculateWeeklyStatistics() async {
    DateTime referenceDate = DateTime.now();
    Map<int, int> weeklyStatistics = {};

    for (int day = DateTime.monday; day <= DateTime.sunday; day++) {
      final dateTime = referenceDate.subtract(Duration(
          days: (referenceDate.weekday - day + 7) %
              7)); // Fix here to handle negative duration
      final minutes = await UserActivityTracker.getMinutesForDay(dateTime);
      weeklyStatistics[day] = minutes;
    }

    return [
      for (int day = DateTime.sunday; day >= DateTime.monday; day--)
        weeklyStatistics[day] ?? 0
    ]; // Return sorted list based on days
  }

  @override
  void onInit() {
    // getStatic();

    super.onInit();
  }
}
