import 'package:flutter/material.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/custom_listtile.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/Pomo_Setting_screen/Pomo_Setting_screen.dart';
import 'package:task_manger/presentation_layer/screen/auth/info_account_screen/widget/custom_circle_Image.dart';
import 'package:task_manger/presentation_layer/screen/edit_screen/edit_screen.dart';
import 'package:task_manger/presentation_layer/screen/notification_screen/notification_screen.dart';
import 'package:task_manger/presentation_layer/screen/profile_screen/widget/profie_showBottomSheet.dart';
import 'package:task_manger/presentation_layer/screen/screenseting/privecy_screen.dart';
import 'package:task_manger/presentation_layer/screen/screenseting/sharescreen.dart';
import 'package:task_manger/presentation_layer/screen/screenseting/terms_screen.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:task_manger/presentation_layer/utils/shard_function/issubscribe.dart';

import '../mange_subscribtion_screen/mange_subscribtion_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppbarProfile(title: 'Profile'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomCircleImage(
                  radius: 70,
                  image: sharedPreferences.getString('image') == null ||
                          sharedPreferences.getString('image')!.isEmpty ||
                          sharedPreferences.getString('image') == ''
                      ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                      : sharedPreferences.getString('image'),
                ),
                SizedBox(height: 10),
                Text(
                  sharedPreferences.getString('name')!,
                  style: MangeStyles().getBoldStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: FontSize.s25 - 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  sharedPreferences.getString('email')!,
                  style: MangeStyles().getRegularStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: FontSize.s14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                CustomListtile(
                  onTap: () {
                    Get.off(() => EditScreen());
                  },
                  titel: 'Edit Profile',
                  image: 'assets/icons/Profile.svg',
                ),
                CustomListtile(
                  onTap: () {
                    Get.to(() => NotificationScreen());
                  },
                  titel: 'Notifications',
                  image: 'assets/icons/notfiction.svg',
                ),
                CustomListtile(
                  onTap: () {
                    Get.to(() => PomoSettingScreen());
                  },
                  titel: 'Pomo Settings',
                  image: 'assets/icons/star.svg',
                ),
                CustomListtile(
                  onTap: () {
                    Get.to(() => ShareApp());
                  },
                  titel: 'Share App',
                  widget: Icon(
                    Icons.share_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                CustomListtile(
                  onTap: () {
                    Get.to(() => PrivacyScreen());
                  },
                  titel: 'Privacy Policy',
                  widget: Icon(
                    Icons.help_outline_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                if (isSubScribe())
                  CustomListtile(
                    onTap: () {
                      Get.to(
                        () => MangeSubscribtionScreen(),
                      );
                    },
                    titel: 'Manage your plan',
                    image: 'assets/icons/manage.svg',
                  ),
                CustomListtile(
                  onTap: () {
                    Get.to(() => TermsAndConditionsPage());
                  },
                  titel: 'Terms and Conditions',
                  image: 'assets/icons/Security.svg',
                ),
                changeMode(),
                CustomListtile(
                  onTap: () {
                    customLogoutShowBottomSheet(context);
                  },
                  titel: 'Logout',
                  image: 'assets/icons/Logout.svg',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class changeMode extends StatefulWidget {
  const changeMode({
    super.key,
  });

  @override
  State<changeMode> createState() => _changeModeState();
}

class _changeModeState extends State<changeMode> {
  late bool isdark;
  @override
  void initState() {
    if (sharedPreferences.getBool("isDarkMode") == true) {
      isdark = true;
    } else {
      isdark = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 25,
        ),
        Icon(
          Icons.visibility,
          color: Theme.of(context).colorScheme.secondary,
        ),
        SizedBox(
          width: 32,
        ),
        Text(
          'Dark Theme',
          style: MangeStyles().getBoldStyle(
            color: ColorManager.kTextlightgray,
            fontSize: FontSize.s16,
          ),
        ),
        Expanded(child: SizedBox()),
        // CustomListtile(
        //   onTap: () {
        //     Get.find<TabAppController>().changeTheme();
        //   },
        //   titel: 'Dark Theme',
        //   widget: Icon(
        //     Icons.visibility,
        //     color: Theme.of(context).colorScheme.secondary,
        //   ),
        //   // image: 'assets/icons/Security.svg',
        // ),
        Switch(
          value: isdark,
          onChanged: (value) async {
            Get.find<TabAppController>().changeTheme();
            setState(() {
              if (sharedPreferences.getBool("isDarkMode") == true) {
                isdark = true;
              } else {
                isdark = false;
              }
            });
          },
        ),
      ],
    );
  }
}
