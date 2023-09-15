import 'package:task_manger/presentation_layer/src/style_packge.dart';

class TaskModel {
  final String subtitle;
  final String? data, time;
  final bool? ishome, isdone;
  final Color? color;
  final String? id, taskName;
  final int? longBreak, workSessions, shortBreak, pomotime;
  TaskModel({
    this.longBreak,
    this.pomotime,
    this.workSessions,
    this.shortBreak,
    this.taskName,
    this.id,
    this.isdone,
    required this.color,
    this.ishome = false,
    required this.subtitle,
    this.data,
    this.time,
  });
}

List<int> taskColors = [
  0xFFFF5726,
  0xFFFFC02D,
  0xFF00A9F1,
  0xFF8BC255,
  0xFFCDDC4C,
  0xFFF54336,
  0xFF607D8A,
];
// List<TaskModel> taskmodelList = [
//   TaskModel(
//     subtitle: '25 minutes',
//     ishome: false,
//     color: Color(0xFFFF5726),
//   ),
//   TaskModel(
//     color: Color(0xFFFFC02D),
//     subtitle: '25 minutes',
//     ishome: false,
//   ),
//   TaskModel(
//     color: Color(0xFF00A9F1),
//     subtitle: '25 minutes',
//     ishome: false,
//   ),
//   TaskModel(
//     color: Color(0xFF8BC255),
//     subtitle: '25 minutes',
//     ishome: false,
//   ),
//   TaskModel(
//     color: Color(0xFFCDDC4C),
//     subtitle: '25 minutes',
//     ishome: false,
//   ),
//   TaskModel(
//     color: Color(0xFFF54336),
//     subtitle: '25 minutes',
//     ishome: false,
//   ),
//   TaskModel(
//     color: Color(0xFF607D8A),
//     subtitle: '25 minutes',
//     ishome: false,
//   ),
// ];
