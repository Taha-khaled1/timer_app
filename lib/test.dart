// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:home_widget/home_widget.dart';
// import 'package:task_manger/main.dart';
// import 'package:workmanager/workmanager.dart';

// // class HomeWidgetExampleProvider extends HomeWidgetProvider {}

// class ScreenTwst extends StatefulWidget {
//   const ScreenTwst({Key? key}) : super(key: key);

//   @override
//   State<ScreenTwst> createState() => _ScreenTwstState();
// }

// class _ScreenTwstState extends State<ScreenTwst> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     HomeWidget.setAppGroupId('YOUR_GROUP_ID');
//     HomeWidget.registerInteractivityCallback(interactiveCallback);
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _checkForWidgetLaunch();
//     HomeWidget.widgetClicked.listen(_launchedFromWidget);
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }

//   Future _sendData() async {
//     try {
//       return Future.wait([
//         HomeWidget.saveWidgetData<String>('title', _titleController.text),
//         HomeWidget.saveWidgetData<String>('message', _messageController.text),
//         HomeWidget.renderFlutterWidget(
//           const Icon(
//             Icons.flutter_dash,
//             size: 200,
//           ),
//           logicalSize: const Size(200, 200),
//           key: 'dashIcon',
//         ),
//       ]);
//     } on PlatformException catch (exception) {
//       debugPrint('Error Sending Data. $exception');
//     }
//   }

//   Future _updateWidget() async {
//     try {
//       return HomeWidget.updateWidget(
//         name: 'HomeWidgetExampleProvider',
//         iOSName: 'HomeWidgetExample',
//       );
//     } on PlatformException catch (exception) {
//       debugPrint('Error Updating Widget. $exception');
//     }
//   }

//   Future _loadData() async {
//     try {
//       return Future.wait([
//         HomeWidget.getWidgetData<String>('title', defaultValue: 'Default Title')
//             .then((value) => _titleController.text = value ?? ''),
//         HomeWidget.getWidgetData<String>(
//           'message',
//           defaultValue: 'Default Message',
//         ).then((value) => _messageController.text = value ?? ''),
//       ]);
//     } on PlatformException catch (exception) {
//       debugPrint('Error Getting Data. $exception');
//     }
//   }

//   Future<void> _sendAndUpdate() async {
//     await _sendData();
//     await _updateWidget();
//   }

//   void _checkForWidgetLaunch() {
//     HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
//   }

//   void _launchedFromWidget(Uri? uri) {
//     if (uri != null) {
//       showDialog(
//         context: context,
//         builder: (buildContext) => AlertDialog(
//           title: const Text('App started from HomeScreenTwstWidget'),
//           content: Text('Here is the URI: $uri'),
//         ),
//       );
//     }
//   }

//   void _startBackgroundUpdate() {
//     Workmanager().registerPeriodicTask(
//       '1',
//       'widgetBackgroundUpdate',
//       frequency: const Duration(minutes: 15),
//     );
//   }

//   void _stopBackgroundUpdate() {
//     Workmanager().cancelByUniqueName('1');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ScreenTwst'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             TextField(
//               decoration: const InputDecoration(
//                 hintText: 'Title',
//               ),
//               controller: _titleController,
//             ),
//             TextField(
//               decoration: const InputDecoration(
//                 hintText: 'Body',
//               ),
//               controller: _messageController,
//             ),
//             ElevatedButton(
//               onPressed: _sendAndUpdate,
//               child: const Text('Send Data to Widget'),
//             ),
//             ElevatedButton(
//               onPressed: _loadData,
//               child: const Text('Load Data'),
//             ),
//             ElevatedButton(
//               onPressed: _checkForWidgetLaunch,
//               child: const Text('Check For Widget Launch'),
//             ),
//             if (Platform.isAndroid)
//               ElevatedButton(
//                 onPressed: _startBackgroundUpdate,
//                 child: const Text('Update in background'),
//               ),
//             if (Platform.isAndroid)
//               ElevatedButton(
//                 onPressed: _stopBackgroundUpdate,
//                 child: const Text('Stop updating in background'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
