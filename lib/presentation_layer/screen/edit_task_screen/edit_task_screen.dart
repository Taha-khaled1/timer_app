// import 'package:flutter/material.dart';

// class EditTaskScreen extends StatelessWidget {
//   const EditTaskScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('EditTaskScreen'),
//       ),
//       body: InfoWidget(
//         builder: (context, deviceInfo) {
//           return Padding(
//             padding:
//                 EdgeInsets.symmetric(horizontal: deviceInfo.localWidth * 0.05),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 20),
//                   Text(
//                     'Title',
//                     style: MangeStyles().getBoldStyle(
//                       color: ColorManager.black,
//                       fontSize: FontSize.s18,
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                   SizedBox(height: 10),
//                   CustomTextfield(
//                     valid: (p0) {
//                       return validInput(p0.toString(), 3, 100, 'name');
//                     },
//                     onsaved: (p0) {},
//                     onChanged: (p0) {
//                       _controller.title = p0.toString();
//                     },
//                     titel: 'Task Title',
//                     width: deviceInfo.localWidth * 1,
//                     height: 60,
//                   ),
//                   SizedBox(height: 20),
//                   GetBuilder<CreateTaskController>(
//                     builder: (controller) {
//                       return Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   'Date',
//                                   style: MangeStyles().getBoldStyle(
//                                     color: ColorManager.black,
//                                     fontSize: FontSize.s18,
//                                   ),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               CustomTextfield(
//                                 readOnly: true,
//                                 textController: controller.dateController,
//                                 valid: (p0) {},
//                                 onsaved: (p0) {},
//                                 onTap: () => _controller.selectDate(context),
//                                 titel: 'Date',
//                                 width: deviceInfo.localWidth * 0.43,
//                                 icon: Icons.calendar_month,
//                                 height: 60,
//                               ),
//                             ],
//                           ),
//                           SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Start Time',
//                                 style: MangeStyles().getBoldStyle(
//                                   color: ColorManager.black,
//                                   fontSize: FontSize.s18,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                               SizedBox(height: 10),
//                               CustomTextfield(
//                                 readOnly: true,
//                                 textController: controller.timeController,
//                                 valid: (p0) {},
//                                 onsaved: (p0) {},
//                                 onTap: () => controller.selectTime(context),
//                                 titel: 'Start Time',
//                                 width: deviceInfo.localWidth * 0.43,
//                                 icon: Icons.access_time_sharp,
//                                 height: 60,
//                               ),
//                             ],
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Chose color',
//                     style: MangeStyles().getBoldStyle(
//                       color: ColorManager.black,
//                       fontSize: FontSize.s18,
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                   SizedBox(height: 10),
//                   SizedBox(
//                     height: 50,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: colorsTask.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return GestureDetector(
//                           onTap: () {
//                             _controller.selectedColorIndex.value =
//                                 index; // Update the selected color index
//                             _controller.selectedColor = colorsTask[index];
//                           },
//                           child: Obx(
//                             () => Container(
//                               width: 50,
//                               height: 40,
//                               margin: EdgeInsets.only(right: 10),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: Color(colorsTask[index]),
//                               ),
//                               child: _controller.selectedColorIndex.value ==
//                                       index
//                                   ? Icon(Icons.check,
//                                       color: Colors
//                                           .white) // Show checkmark if color is selected
//                                   : null,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.only(left: 10),
//                   //   child: Text(
//                   //     'Select Category',
//                   //     style: MangeStyles().getBoldStyle(
//                   //       color: ColorManager.black,
//                   //       fontSize: FontSize.s18,
//                   //     ),
//                   //     textAlign: TextAlign.left,
//                   //   ),
//                   // ),
//                   // SizedBox(height: 10),
//                   // MyDropdownButton(),
//                   SizedBox(height: 20),
//                   GetBuilder<CreateTaskController>(
//                     builder: (controller) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Text(
//                               'set of pomo',
//                               style: MangeStyles().getBoldStyle(
//                                 color: ColorManager.black,
//                                 fontSize: FontSize.s18,
//                               ),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           SfSlider(
//                             min: 1,
//                             max: 60,
//                             activeColor: Color(0xff0FB9B1),
//                             inactiveColor: ColorManager.grey2,
//                             value: _controller.pomotime.toInt(),
//                             interval: 59,
//                             showTicks: false,
//                             showLabels: true,
//                             enableTooltip: true,
//                             minorTicksPerInterval: 0,
//                             thumbShape: SfThumbShape(),
//                             onChanged: (dynamic value) {
//                               _controller.setSliderValue(
//                                 value.toInt(),
//                               );
//                             },
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Text(
//                               'set of pomo',
//                               style: MangeStyles().getBoldStyle(
//                                 color: ColorManager.black,
//                                 fontSize: FontSize.s18,
//                               ),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           SfSlider(
//                             min: 1,
//                             max: 3,
//                             activeColor: Color(0xff0FB9B1),
//                             inactiveColor: ColorManager.grey2,
//                             value: _controller.sliderValue1.toInt(),
//                             interval: 2,
//                             showTicks: false,
//                             showLabels: true,
//                             enableTooltip: true,
//                             minorTicksPerInterval: 0,
//                             thumbShape: SfThumbShape(),
//                             onChanged: (dynamic value) {
//                               _controller.setSliderValue1(value);
//                             },
//                           ),
//                           SizedBox(height: 10),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Text(
//                               'Long Break',
//                               style: MangeStyles().getBoldStyle(
//                                 color: ColorManager.black,
//                                 fontSize: FontSize.s18,
//                               ),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           SfSlider(
//                             min: 1,
//                             max: 15.0,
//                             activeColor: Color(0xff0FB9B1),
//                             inactiveColor: ColorManager.grey2,
//                             value: _controller.sliderValue2.toInt(),
//                             interval: 14.0,
//                             showTicks: false,
//                             showLabels: true,
//                             enableTooltip: true,
//                             minorTicksPerInterval: 0,
//                             thumbShape: SfThumbShape(),
//                             onChanged: (dynamic value) {
//                               _controller.setSliderValue2(value);
//                             },
//                           ),
//                           SizedBox(height: 10),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Text(
//                               'Short Break',
//                               style: MangeStyles().getBoldStyle(
//                                 color: ColorManager.black,
//                                 fontSize: FontSize.s18,
//                               ),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           SfSlider(
//                             min: 1,
//                             max: 8.0,
//                             activeColor: Color(0xff0FB9B1),
//                             inactiveColor: ColorManager.grey2,
//                             value: _controller.sliderValue3.toInt(),
//                             interval: 7.0,
//                             showTicks: false,
//                             showLabels: true,
//                             enableTooltip: true,
//                             minorTicksPerInterval: 0,
//                             thumbShape: SfThumbShape(),
//                             onChanged: (dynamic value) {
//                               _controller.setSliderValue3(value);
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   // GetBuilder<CreateTaskController>(
//                   //   builder: (controller) {
//                   //     return controller.isloading == false
//                   //         ? CustomButton(
//                   //             width: deviceInfo.localWidth * 0.9,
//                   //             haigh: 60,
//                   //             color: ColorManager.kPrimary,
//                   //             text: 'Create New Task',
//                   //             press: () async {
//                   //               _controller.createTask();
//                   //             },
//                   //           )
//                   //         : Center(
//                   //             child: Padding(
//                   //               padding:
//                   //                   const EdgeInsets.symmetric(vertical: 15),
//                   //               child: Align(
//                   //                 alignment: Alignment.center,
//                   //                 child: CircularProgressIndicator(
//                   //                   color: ColorManager.kPrimary,
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //           );
//                   //   },
//                   // ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
