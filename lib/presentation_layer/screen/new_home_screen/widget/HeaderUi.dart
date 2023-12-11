import 'package:task_manger/presentation_layer/screen/new_home_screen/widget/Tag.dart';
import 'package:task_manger/presentation_layer/src/style_packge.dart';

class HeaderUi extends StatelessWidget {
  const HeaderUi({
    super.key,
    this.onTap,
    this.onTap2,
  });
  final void Function()? onTap;
  final void Function()? onTap2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      child: Row(
        children: [
          Text(
            'Tasks',
            style: MangeStyles().getBoldStyle(
              color: ColorManager.kPrimary,
              fontSize: FontSize.s25,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(child: SizedBox()),
          GestureDetector(onTap: onTap, child: Tag(text: 'Not complete')),
          SizedBox(
            width: 8,
          ),
          GestureDetector(onTap: onTap2, child: Tag(text: 'Today')),
        ],
      ),
    );
  }
}
