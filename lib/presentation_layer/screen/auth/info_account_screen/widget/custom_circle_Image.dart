import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dating_app/main.dart';
// import 'package:dating_app/presentation_layer/src/style_packge.dart';
import 'package:flutter/material.dart';

class CustomCircleImage extends StatelessWidget {
  const CustomCircleImage(
      {Key? key, required this.radius, this.image, this.isWidget = false})
      : super(key: key);
  final double radius;
  final String? image;
  final bool? isWidget;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      // استخدام عنصر ClipOval لعرض الصورة بشكل كامل داخل دائرة CircleAvatar
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl:
              image!, //?? sharedPreferences.getString('image').toString(),
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit
              .fill, // تحديد كيفية توسيط وتغطية الصورة داخل دائرة ال CircleAvatar
        ),
      ),
    );
  }
}

class CustomCircleImageAsset extends StatelessWidget {
  const CustomCircleImageAsset(
      {Key? key,
      required this.radius,
      this.image,
      required this.color,
      this.onTap})
      : super(key: key);
  final double radius;
  final String? image;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color,
        radius: radius,
        child: ClipOval(
          child: Image.asset(
            image!,
            width: radius * 2,
            height: radius * 2,
          ),
        ),
      ),
    );
  }
}
