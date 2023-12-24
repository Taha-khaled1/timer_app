import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:task_manger/presentation_layer/utils/shard_function/is_login.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:task_manger/application_layer/app/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

// import io.flutter.embedding.android.FlutterActivity
late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51MU9CFCCrii3tAGhhhWlPda7dhODreaYeE8HtdP4gvjoIalVprrKcl7QHnEfLFzvlHC7jrlOpYMR8ncwLjDeOh5V00PcfEjAX9';
  // Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("lev") == null) {
    sharedPreferences.setString("lev", '0');
  }
  tz.initializeTimeZones();
  await Firebase.initializeApp();
  if (isLogin()) {
    await getUserData();
  }
  DateTime firstDateTime = DateTime.now();
  const String _keyPrefix = 'user_activity_';
  final formattedDate =
      "${firstDateTime.year}-${firstDateTime.month}-${firstDateTime.day}";
  final key = '$_keyPrefix$formattedDate';
  if (sharedPreferences.getInt(key) == null) {
    sharedPreferences.setInt(key, 0);
  }
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

/// Used for Background Updates using Workmanager Plugin
// @pragma("vm:entry-point")
// void callbackDispatcher() {
//   Workmanager().executeTask((taskName, inputData) {
//     final now = DateTime.now();
//     return Future.wait<bool?>([
//       HomeWidget.saveWidgetData(
//         'title',
//         'Updated from Background',
//       ),
//       HomeWidget.saveWidgetData(
//         'message',
//         '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
//       ),
//       HomeWidget.updateWidget(
//         name: 'HomeWidgetExampleProvider',
//         iOSName: 'HomeWidgetExample',
//       ),
//     ]).then((value) {
//       return !value.contains(false);
//     });
//   });
// }

// /// Called when Doing Background Work initiated from Widget
// @pragma("vm:entry-point")
// Future<void> interactiveCallback(Uri? data) async {
//   if (data?.host == 'titleclicked') {
//     final greetings = [
//       'Hello',
//       'Hallo',
//       'Bonjour',
//       'Hola',
//       'Ciao',
//       '哈洛',
//       '안녕하세요',
//       'xin chào',
//     ];
//     final selectedGreeting = greetings[Random().nextInt(greetings.length)];
//     await HomeWidget.setAppGroupId('YOUR_GROUP_ID');
//     await HomeWidget.saveWidgetData<String>('title', selectedGreeting);
//     await HomeWidget.updateWidget(
//       name: 'HomeWidgetExampleProvider',
//       iOSName: 'HomeWidgetExample',
//     );
//   }
// }


// @pragma("vm:entry-point")
// void overlayMain() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   sharedPreferences = await SharedPreferences.getInstance();
//   if (sharedPreferences.getString("lev") == null) {
//     sharedPreferences.setString("lev", '0');
//   }
//   tz.initializeTimeZones();
//   await Firebase.initializeApp();

//   DateTime firstDateTime = DateTime.now();
//   const String _keyPrefix = 'user_activity_';
//   final formattedDate =
//       "${firstDateTime.year}-${firstDateTime.month}-${firstDateTime.day}";
//   final key = '$_keyPrefix$formattedDate';
//   if (sharedPreferences.getInt(key) == null) {
//     sharedPreferences.setInt(key, 0);
//   }
//   runApp(
//     const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: TaskOverlay(),
//     ),
//   );
// }

// import 'dart:async';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:home_widget/home_widget.dart';
// import 'package:workmanager/workmanager.dart';