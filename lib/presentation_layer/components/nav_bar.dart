// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manger/data_layer/models/task_model.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/create_task_screen/create_task_screen.dart';
import 'package:task_manger/presentation_layer/screen/home_screen/home_screen.dart';
import 'package:task_manger/presentation_layer/screen/new_home_screen/new_home_screen.dart';
import 'package:task_manger/presentation_layer/screen/note_screen/add_note_screen.dart';
import 'package:task_manger/presentation_layer/screen/note_screen/note_screen.dart';
import 'package:task_manger/presentation_layer/screen/pomodoro_timer_screen/pomodoro_timer_screen.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/statistic_screen.dart';
import 'package:task_manger/presentation_layer/screen/task_screen/task_screen.dart';

List<String> svgIcon = [
  'assets/icons/Home.svg',
  'assets/icons/Calendar.svg',
  'assets/icons/Plus.svg',
  'assets/icons/Chart.svg',
  'assets/icons/static.svg',
];
List<String> titles = [
  'Home',
  'Task',
  '',
  'Statistics',
  'Notes',
];

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Color> iconColors = [ColorManager.kPrimary, Colors.grey];
  final List<Widget> _screens = [
    NewHomeScreen(),
    TaskScreen(),
    CreateTaskScreen(),
    StatisticScreen(),
    NoteScreen(),
  ];

  final tabController = Get.put(TabAppController());
  bool middleButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Obx(
        () => Stack(
          children: [
            _screens[tabController.currentIndex.value],
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Visibility(
                visible: middleButtonPressed,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        isExtended: true,
                        onPressed: () {
                          Get.to(() => CreateTaskScreen());
                          print("First FAB Pressed");
                        },
                        heroTag: null,
                        child: Text("Task"),
                        backgroundColor: Colors.blue,
                      ),
                      SizedBox(width: 16.0),
                      FloatingActionButton(
                        onPressed: () {
                          Get.to(() => AddNoteScreen());
                          print("Second FAB Pressed");
                        },
                        heroTag: null,
                        child: Text("Note"),
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<TabAppController>(
        init: TabAppController(),
        initState: (_) {},
        builder: (_) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            elevation: 10,
            showUnselectedLabels: true,
            unselectedItemColor: iconColors.last,
            unselectedLabelStyle: MangeStyles().getRegularStyle(
              color: Colors.grey,
              fontSize: FontSize.s14,
            ),
            selectedItemColor: iconColors.first,
            selectedLabelStyle: TextStyle(color: Colors.red),
            currentIndex: tabController.currentIndex.value,
            onTap: (index) {
              if (index == 2) {
                // Toggle the middle button state
                setState(() {
                  middleButtonPressed = !middleButtonPressed;
                });
              } else {
                // Change the tab
                setState(() {
                  middleButtonPressed = false;
                  // Change this to the appropriate index based on your tabs
                });
                tabController.changeTabIndex(index);
              }
            },
            items: [
              for (int i = 0; i < 5; i++)
                BottomNavigationBarItem(
                  icon: Container(
                    child: titles[i] != ''
                        ? SvgPicture.asset(svgIcon[i],
                            height: 30,
                            color: iconColors[
                                i == tabController.currentIndex.value ? 0 : 1])
                        : CircleAvatar(
                            radius: 30,
                            backgroundColor: ColorManager.kPrimary,
                            child: SvgPicture.asset(
                              svgIcon[i],
                              color: Colors.white,
                            ),
                          ),
                  ),
                  label: titles[i],
                ),
            ],
          );
        },
      ),
    );
  }
}

class TabAppController extends GetxController {
  var currentIndex = 0.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
    update();
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: Center(
        child: Text('Screen 2'),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3'),
      ),
      body: Center(
        child: Text('Screen 3'),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 4'),
      ),
      body: Center(
        child: Text('Screen 4'),
      ),
    );
  }
}

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 5'),
      ),
      body: Center(
        child: Text('Screen 5'),
      ),
    );
  }
}

class Screen6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 6'),
      ),
      body: Center(
        child: Text('Screen 6'),
      ),
    );
  }
}

class Screen7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 7'),
      ),
      body: Center(
        child: Text('Screen 7'),
      ),
    );
  }
}
