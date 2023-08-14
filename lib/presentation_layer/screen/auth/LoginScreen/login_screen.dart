import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/components/custom_text_field.dart';
import 'package:task_manger/presentation_layer/components/nav_bar.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/auth/LoginScreen/login_controller/login_controller.dart';
import 'package:task_manger/presentation_layer/screen/auth/LoginScreen/widget/RemperCHeckBox.dart';
import 'package:task_manger/presentation_layer/screen/auth/LoginScreen/widget/circle_social_button.dart';
import 'package:task_manger/presentation_layer/screen/auth/forget_password/forget_password.dart';
import 'package:task_manger/presentation_layer/screen/auth/info_account_screen/info_account_screen.dart';
import 'package:task_manger/presentation_layer/screen/auth/siginUp_screen/siginUp_screen.dart';
import 'package:task_manger/presentation_layer/screen/auth/social_login/social_login.dart';
import 'package:task_manger/presentation_layer/screen/auth/social_login/widget/EndAuthPage.dart';
import 'package:task_manger/presentation_layer/screen/auth/social_login/widget/custom_dvider.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    Future<UserCredential> signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: SizedBox(
              height: deviceInfo.localHeight,
              child: Column(
                children: [
                  Spacer(),
                  Padding(
                    padding:
                        EdgeInsets.only(left: deviceInfo.localWidth * 0.07),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login to your\nAccount',
                        style: MangeStyles().getBoldStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s40 + 8,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Spacer(),
                  Form(
                    key: loginController.formKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          valid: (p0) {
                            return validInput(p0.toString(), 3, 100, 'email');
                          },
                          onsaved: (p0) {
                            loginController.emailAddress = p0.toString();
                          },
                          titel: 'Email',
                          width: deviceInfo.localWidth * 0.8,
                          icon: Icons.email,
                          height: 60,
                        ),
                        SizedBox(height: 20),
                        CustomTextfield(
                          valid: (p0) {
                            return validInput(
                              p0.toString(),
                              3,
                              100,
                              'password',
                            );
                          },
                          onsaved: (p0) {
                            loginController.password = p0.toString();
                          },
                          titel: 'Password',
                          width: deviceInfo.localWidth * 0.8,
                          icon: Icons.lock,
                          obsecuer: true,
                          height: 60,
                        ),
                        SizedBox(height: 10),
                        RemperCHeckBox(),
                      ],
                    ),
                  ),
                  CustomButton(
                    width: deviceInfo.localWidth * 0.8,
                    rectangel: 18,
                    haigh: 60,
                    color: ColorManager.kPrimaryButton,
                    text: "Sign in",
                    press: () {
                      if (loginController.formKey.currentState!.validate()) {
                        loginController.formKey.currentState!.save();
                        loginController.signInWithEmailAndPassword();
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(() => ForgetPasswordScreen());
                    },
                    child: Text(
                      'Forgot the password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF7206FC),
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ),
                  Spacer(),
                  CustomDvider(title: 'or continue with'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleSocialButton(image: 'assets/icons/facebook.svg'),
                      CircleSocialButton(
                        image: 'assets/icons/google.svg',
                        onTap: () async {
                          try {
                            final CollectionReference usersCollection =
                                FirebaseFirestore.instance.collection('users');
                            UserCredential user = await signInWithGoogle();
                            if (user.user != null) {
                              saveInformition(
                                displayName: user.user!.displayName!,
                                email: user.user!.email!,
                                image: user.user!.photoURL!,
                                id: user.user!.uid!,
                              );
                              final String userId =
                                  sharedPreferences.getString('id')!;

                              usersCollection
                                  .doc(userId)
                                  .get()
                                  .then((docSnapshot) {
                                if (docSnapshot.exists) {
                                  Get.offAll(() => MainScreen());
                                  sharedPreferences.setString("lev", '2');
                                } else {
                                  Get.offAll(() => InfoAccount());
                                }
                              });
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                      CircleSocialButton(image: 'assets/icons/apple.svg'),
                    ],
                  ),
                  SizedBox(height: 20),
                  EndAuthPage(
                    title: 'Don’t have an account?',
                    title2: 'Sign up',
                    onTap: () {
                      Get.off(() => SiginUpScreen());
                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
