import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/components/show_dialog.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/widget/HeaderContainer.dart';
import 'package:task_manger/presentation_layer/screen/subscribe_screen/subscription_screen.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class MangeSubscribtionScreen extends StatefulWidget {
  const MangeSubscribtionScreen({Key? key}) : super(key: key);

  @override
  State<MangeSubscribtionScreen> createState() =>
      _MangeSubscribtionScreenState();
}

class _MangeSubscribtionScreenState extends State<MangeSubscribtionScreen> {
  late Duration difference;
  late String amount;
  String HowMonth() {
    if (sharedPreferences.getString('type_pay') == "month") {
      amount = "4.9";
      return "1 Month";
    } else if (sharedPreferences.getString('type_pay') == "year") {
      amount = "34.8";
      return "12 Month";
    } else {
      amount = "19.9";
      return "6 Month";
    }
  }

  @override
  void initState() {
    String dateValue = sharedPreferences.getString("timepay_at")!;

    DateTime parsedDate = DateTime.parse(dateValue);
    DateTime currentDate = DateTime.now();
    difference = currentDate.difference(parsedDate);
    // printRedColor(difference.inDays.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppbarProfile(title: 'Manage your plan', isBack: true),
      body: InfoWidget(builder: (context, deviceInfo) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Manage Your Plan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7206FC),
                  fontSize: 32,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  // height: 0.03,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Enjoy full access without ads and restrictions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                  // height: 0.09,
                  // letterSpacing: 0.20,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.kPrimary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: ListTile(
                    // activeColor: ColorManager.kPrimary,
                    title: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            HowMonth(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                              height: 0.06,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            '\$$amount',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                              height: 0.06,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(
                      'Pay once, cancel any time',
                      style: TextStyle(
                        color: Color(0xFF616161),
                        fontSize: 12,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        height: 0,
                        letterSpacing: 0.20,
                      ),
                    ),
                    isThreeLine: true,
                    // value: 'Option 3',
                    // groupValue: _selectedOption,
                    // onChanged: (value) {
                    //   setState(() {
                    //     _selectedOption = value!;
                    //     print("object");
                    //   });
                    // },
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeaderContainer(
                    title: 'Consumed days',
                    text: difference.inDays.toString(),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  HeaderContainer(
                    title: 'Status',
                    text: "Active",
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: deviceInfo.localWidth * 0.44,
                    haigh: 55,
                    color: ColorManager.error,
                    text: "cancel plan",
                    press: () async {
                      showDilog(
                        context,
                        "Are you sure cancel your plan",
                        type: QuickAlertType.warning,
                        onConfirmBtnTap: () async {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(sharedPreferences.getString("id"))
                              .update({
                            'timepay_at': null,
                            'pay': null,
                            'type_pay': null,
                          });
                          sharedPreferences.remove("timepay_at");
                          sharedPreferences.remove("pay");
                          sharedPreferences.remove("type_pay");
                          Get.offAll(() => MainScreen());
                        },
                      );
                    },
                  ),
                  CustomButton(
                    width: deviceInfo.localWidth * 0.44,
                    haigh: 55,
                    color: ColorManager.kPrimary,
                    text: "change plan",
                    press: () async {
                      Get.to(() => SubscriptionScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
