import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manger/main.dart';

bool isLogin() {
  if (sharedPreferences.getString("id") != null) {
    return true;
  }
  return false;
}

Future<void> getUserData() async {
  var user = await FirebaseFirestore.instance
      .collection('users')
      .doc(sharedPreferences.getString("id"))
      .get();
  sharedPreferences.setString("timepay_at", user['timepay_at']);
  sharedPreferences.setBool("pay", user['pay']);
  sharedPreferences.setString("type_pay", user['type_pay']);
}
