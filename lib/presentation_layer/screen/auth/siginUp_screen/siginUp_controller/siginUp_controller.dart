import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/screen/auth/info_account_screen/info_account_screen.dart';
import 'package:task_manger/presentation_layer/screen/auth/social_login/social_login.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';
import 'package:task_manger/presentation_layer/src/style_packge.dart';

class SiginUpController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isCheckBox = false;
  bool isload = false;
  void updateCheckBox(bool val) {
    isCheckBox = val;
    update();
  }

  late String emailAddress, password;

  void createAccount(BuildContext context) async {
    try {
      isload = true;
      update();
      print('222222222222222');
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      sharedPreferences.setString('id', credential.user!.uid);
      sharedPreferences.setString('email', credential.user!.email!);

      Get.offAll(() => InfoAccount(
            isgoogle: false,
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    isload = false;
    update();
  }
}
