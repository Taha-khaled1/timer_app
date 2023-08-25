import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';

class NoteController extends GetxController {
  String title = '';
  String message = '';
  bool isNoteLoad = false;
  void createNote() async {
    isNoteLoad = true;
    update();
    if (message.isEmpty || title.isEmpty) {
      showToast('There are some empty fields');
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(sharedPreferences.getString('id'))
          .collection('notes')
          .add({
        'title': title,
        'note': message,
      });
      title = '';
      message = '';
      isNoteLoad = false;
      update();
      Get.back();
      showToast('Note added successfully');
    }
    isNoteLoad = false;
    update();
  }

  Future getNotes() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(sharedPreferences.getString('id')!)
              .collection('notes')
              .get();

      return snapshot;
    } catch (e) {
      showToast('There is a problem');
    }
  }
}
