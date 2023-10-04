import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';

class NewHomeController extends GetxController {
  int? totalusers;
  List<Widget> ximageoffer = [];
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
    totalusers = await getNumberOfUsers();
    return tasks;
  }

  Future<int> getNumberOfUsers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    return querySnapshot.docs.length;
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
}
