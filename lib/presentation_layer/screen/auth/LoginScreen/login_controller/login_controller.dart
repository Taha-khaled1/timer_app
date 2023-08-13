import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_manger/presentation_layer/src/style_packge.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isCheckBox = false;

  void updateCheckBox(bool val) {
    isCheckBox = val;
    update();
  }
}
