import 'package:timezone/data/latest_all.dart' as tz;
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:task_manger/application_layer/app/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manger/presentation_layer/notification_service/notification_service.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("lev") == null) {
    sharedPreferences.setString("lev", '0');
  }
  // requestBatteryOptimizationExemption();
  tz.initializeTimeZones();
  await Firebase.initializeApp();
  await NotificationService().initializePlatformNotifications();
  await AndroidAlarmManager.initialize();
  // FlutterBackgroundService().i;

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

// // this will be used as notification channel id
// const notificationChannelId = 'my_foreground';

// // this will be used for notification id, So you can update your custom notification with this id.
// const notificationId = 888;

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();

//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     notificationChannelId, // id
//     'MY FOREGROUND SERVICE', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.low, // importance must be at low or higher level
//   );

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   await service.configure(
//     iosConfiguration: IosConfiguration(),
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,

//       // auto start service
//       autoStart: true,
//       isForegroundMode: true,

//       notificationChannelId:
//           notificationChannelId, // this must match with notification channel you created above.
//       initialNotificationTitle: 'AWESOME SERVICE',
//       initialNotificationContent: 'Initializing',
//       foregroundServiceNotificationId: notificationId,
//     ),
//   );
// }

// void printHello() {
//   final DateTime now = DateTime.now();
//   final int isolateId = Isolate.current.hashCode;
//   print("[$now] Hello, world! isolate=${isolateId} function='$printHello");
// }

// Future<void> onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
//         flutterLocalNotificationsPlugin.show(
//           notificationId,
//           'COOL SERVICE',
//           'Awesome ${DateTime.now()}',
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               notificationChannelId,
//               'MY FOREGROUND SERVICE',
//               icon: 'ic_bg_service_small',
//               ongoing: true,
//             ),
//           ),
//         );
//       }
//     }
//   });
// }
