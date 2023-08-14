import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';

class TaskController extends GetxController {
  Future<List<Map<String, dynamic>>> getTasksBydata(DateTime dateTime) async {
    String userId = sharedPreferences.getString('id') ?? '';

    QuerySnapshot taskSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('datatime',
            isEqualTo: '${dateTime.year}/${dateTime.month}/${dateTime.day}')
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
}
