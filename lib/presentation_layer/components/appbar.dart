import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task_manger/presentation_layer/screen/notification_screen/notification_screen.dart';
import 'package:task_manger/presentation_layer/screen/profile_screen/profile_screen.dart';
import 'package:task_manger/presentation_layer/src/style_packge.dart';

PreferredSizeWidget appbar({String? title}) {
  return AppBar(
    elevation: 0,
    // backgroundColor:Theme.of(context).colorScheme.background,
    leading: Builder(builder: (context) {
      return BackButton(
        color: Theme.of(context).colorScheme.secondary,
      );
    }),
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
      // backgroundColor:Theme.of(context).colorScheme.background,
      leading: widget.isBack
          ? BackButton(
              color: Theme.of(context).colorScheme.secondary,
            )
          : SizedBox(),
      centerTitle: false,
      title: Transform.translate(
        offset: Offset(widget.isBack ? -20 : 0, 0),
        child: Text(
          widget.title ?? '',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
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
              child: SvgPicture.asset(
                'assets/icons/pro.svg',
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        if (moreIcon)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: SvgPicture.asset(
                'assets/icons/train.svg',
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        if (moreIcon)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () async {
                bool? status = await FlutterOverlayWindow.isPermissionGranted();
                if (status) {
                  print(WindowSize.matchParent);
                  await FlutterOverlayWindow.showOverlay(
                    enableDrag: false,
                    overlayTitle: "X-SLAYER",
                    overlayContent: 'Overlay Enabled',
                    flag: OverlayFlag.defaultFlag,
                    visibility: NotificationVisibility.visibilityPublic,
                    positionGravity: PositionGravity.auto,
                    height: 1200,
                    width: 900,
                  );
                  print("FlutterOverlayWindow");
                } else {
                  status = await FlutterOverlayWindow.requestPermission();
                }
              },
              child: Image.asset(
                'assets/icons/icons8-barcode-64.png',
                width: 20,
                color: Theme.of(context).colorScheme.secondary,
              ),
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
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
