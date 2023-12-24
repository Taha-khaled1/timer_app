import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/src/components_packge.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import '../../resources/color_manager.dart';
import 'package:http/http.dart' as http;

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _selectedOption = 'Option 2';
  var paymentIntent = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppbarProfile(title: '', isBack: true),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose Your Plan',
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
                  height: 11,
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
                Image.asset(
                  "assets/images/prize.png",
                  width: 250,
                  height: 300,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedOption == "Option 1"
                          ? ColorManager.kPrimary
                          : ColorManager.background,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: RadioListTile<String>(
                      activeColor: ColorManager.kPrimary,
                      title: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              '1 Month',
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
                              '\$4.9',
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
                      value: 'Option 1',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          print("oOOOOObject");
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 120,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 95,
                          width: deviceInfo.localWidth * 0.93,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedOption == "Option 2"
                                  ? ColorManager.kPrimary
                                  : ColorManager.background,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: RadioListTile<String>(
                              activeColor: ColorManager.kPrimary,
                              title: SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Text(
                                      '6 Month',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 20,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w700,
                                        height: 0.06,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text(
                                      '\$19.9',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 20,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w700,
                                        height: 0.06,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
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
                                  Expanded(child: SizedBox()),
                                  Text(
                                    '\$3.33/mo',
                                    style: MangeStyles().getBoldStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                ],
                              ),
                              isThreeLine: true,
                              value: 'Option 2',
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                  print("oOOOOObject");
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        // left: 0,
                        // right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          width: 110,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "save 50%",
                            style: MangeStyles().getBoldStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedOption == "Option 3"
                          ? ColorManager.kPrimary
                          : ColorManager.background,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: RadioListTile<String>(
                      activeColor: ColorManager.kPrimary,
                      title: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              '12 Months',
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
                              '\$34.9',
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
                      subtitle: Row(
                        children: [
                          Text(
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
                          Expanded(child: SizedBox()),
                          Text(
                            '\$2.9/mo',
                            style: MangeStyles().getBoldStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      value: 'Option 3',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                          print("object");
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomButton(
                  width: deviceInfo.localWidth * 0.9,
                  haigh: 55,
                  color: ColorManager.kPrimary,
                  text: "get this plan",
                  press: () async {
                    await makePayment();
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  double calcAmount() {
    if (_selectedOption == 'Option 1') {
      return 4.9;
    } else if (_selectedOption == 'Option 2') {
      return 19.9;
    } else {
      return 34.8;
    }
  }

  Future<void> makePayment() async {
    try {
      //STEP 1: Create Payment Intent
      double amount = calcAmount();
      paymentIntent =
          await createPaymentIntent(((amount * 100).round()).toString(), 'usd');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // style: ThemeMode.light,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> userSuccssPay() async {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences.getString('id'));
    sharedPreferences.setString("timepay_at", DateTime.now().toString());
    sharedPreferences.setBool("pay", true);
    sharedPreferences.setString(
      "type_pay",
      _selectedOption == "Option 2"
          ? "half-year"
          : _selectedOption == "Option 1"
              ? "month"
              : "year",
    );
    await userDoc.update({
      'timepay_at': sharedPreferences.getString('timepay_at'),
      'pay': sharedPreferences.getBool('pay'),
      'type_pay': sharedPreferences.getString('type_pay'),
    });
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        paymentIntent =
            null; // Clear paymentIntent variable after successful payment.
        print('Payment made successfully.');
        await userSuccssPay();
        Get.back();
        // showDilog(context, "Payment made successfully");
      }).onError((error, stackTrace) {
        // showDilog(context, "Error while displaying Payment Sheet");
        print('Error while displaying Payment Sheet: $error');
      });
    } on StripeException catch (e) {
      // showDilog(context, "Error while displaying Payment Sheet");

      print('Stripe error: $e');
    } catch (e) {
      // showDilog(context, "Error while displaying Payment Sheet");

      print('General error while displaying Payment Sheet: $e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51MU9CFCCrii3tAGhjMS2lA168mdfX5xkvJpdM5aBOWVDyaczVSCyPDI4UNilOo6QkK8gDr8NaLiwxLKjY5Bv2HqT006FQ6Vg7g',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
