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

class AppbarProfile extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBack;

  AppbarProfile({Key? key, this.title, this.isBack = true}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<AppbarProfile> createState() => _AppbarProfileState();
}

class _AppbarProfileState extends State<AppbarProfile> {
  bool moreIcon = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorManager.background,
      leading: widget.isBack
          ? BackButton(
              color: ColorManager.black,
            )
          : SizedBox(),
      centerTitle: false,
      title: Transform.translate(
        offset: Offset(widget.isBack ? -38 : 0, 0),
        child: Text(
          widget.title ?? '',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 24,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
            height: 1.20,
          ),
        ),
      ),
      actions: [
        if (moreIcon)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Get.to(() => ProfileScreen());
              },
              child: SvgPicture.asset('assets/icons/pro.svg'),
            ),
          ),
        if (moreIcon)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: SvgPicture.asset('assets/icons/train.svg'),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                moreIcon = !moreIcon;
                print(moreIcon);
              });
            },
            child: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
