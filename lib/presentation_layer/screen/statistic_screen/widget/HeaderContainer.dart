import 'package:task_manger/presentation_layer/src/style_packge.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    super.key,
    required this.title,
    required this.text,
  });
  final String title, text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 180,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorManager.fillColor,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '$title\n',
          style: MangeStyles().getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s17,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '$text',
              style: MangeStyles().getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
