import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task_manger/presentation_layer/screen/notification_screen/notification_screen.dart';
import 'package:task_manger/presentation_layer/screen/profile_screen/profile_screen.dart';
import 'package:task_manger/presentation_layer/src/style_packge.dart';

PreferredSizeWidget appbar({String? title}) {
  return AppBar(
    elevation: 0,
    backgroundColor: ColorManager.background,
    leading: BackButton(
      color: ColorManager.black,
    ),
    centerTitle: false,
    title: Text(
      title ?? '',
      style: TextStyle(
        color: Color(0xFF212121),
        fontSize: 24,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w700,
        height: 1.20,
      ),
    ),
  );
}

PreferredSizeWidget appbarProfile({String? title}) {
  return AppBar(
    elevation: 0,
    backgroundColor: ColorManager.background,
    leading: BackButton(
      color: ColorManager.black,
    ),
    centerTitle: false,
    title: Text(
      title ?? '',
      style: TextStyle(
        color: Color(0xFF212121),
        fontSize: 24,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w700,
        height: 1.20,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () {
            Get.to(() => ProfileScreen());
          },
          child: SvgPicture.asset('assets/icons/pro.svg'),
        ),
      ),
    ],
  );
}

PreferredSizeWidget appbarMain({String? title, String? image, Widget? widget}) {
  return AppBar(
    elevation: 0,
    backgroundColor: ColorManager.background,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Image.asset(image ?? 'assets/images/logo.png'),
    ),
    title: Text(
      title ?? 'pomo',
      style: MangeStyles().getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s20,
      ),
    ),
    actions: [
      widget ??
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: SvgPicture.asset('assets/icons/train.svg'),
            ),
          ),
    ],
  );
}
