import 'package:flutter/material.dart';
import 'package:task_manger/data_layer/models/task_model.dart';

class CardPromoTimer extends StatelessWidget {
  const CardPromoTimer({
    super.key,
    required this.taskModel,
    required this.istowSubtitle,
  });
  final TaskModel taskModel;
  final bool istowSubtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 24,
        bottom: 20,
      ),
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0C04060F),
            blurRadius: 60,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              color: taskModel.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 28,
                  height: 28,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(children: [
                    Image.asset(taskModel.image),
                  ]),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      taskModel.taskName ?? "",
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 20,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      '25 minutes',
                      style: TextStyle(
                        color: Color(0xFF616161),
                        fontSize: 14,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       if (istowSubtitle)
          //         Text(
          //           '2/4',
          //           textAlign: TextAlign.right,
          //           style: TextStyle(
          //             color: Color(0xFF424242),
          //             fontSize: 20,
          //             fontFamily: 'Urbanist',
          //             fontWeight: FontWeight.w700,
          //             height: 1.20,
          //           ),
          //         ),
          //       const SizedBox(height: 8),
          //       Text(
          //         '${taskModel.subtitle}',
          //         textAlign: TextAlign.right,
          //         style: TextStyle(
          //           color: Color(0xFF616161),
          //           fontSize: 14,
          //           fontFamily: 'Urbanist',
          //           fontWeight: FontWeight.w500,
          //           height: 1.40,
          //           letterSpacing: 0.20,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
