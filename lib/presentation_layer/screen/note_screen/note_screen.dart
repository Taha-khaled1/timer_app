import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/appbar.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/screen/note_screen/widget/NoteCard.dart';
import 'package:task_manger/presentation_layer/src/show_toast.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  String title = '';
  String message = '';
  bool isNoteLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbarProfile(title: 'Notes', isBack: false),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: deviceInfo.localWidth * 0.04),
            child: Column(
              children: [
                FutureBuilder(
                  builder: (ctx, snapshot) {
                    // Checking if future is resolved or not
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: TextStyle(fontSize: 18),
                          ),
                        );

                        // if we got our data
                      } else if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        final data = snapshot.data;
                        // print(data.data());
                        return Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // This defines the number of items in a row. Adjust as needed.
                              childAspectRatio:
                                  1.0, // Adjust for your desired width/height ratio
                              crossAxisSpacing:
                                  10, // Spacing between the items in a row
                              mainAxisSpacing: 10, // Spacing between the rows
                            ),
                            itemCount: data?.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return NoteCard(
                                des: data?.docs[index]['note'],
                                title: data?.docs[index]['title'],
                                id: data?.docs[index]['id'],
                                star: data?.docs[index]['star'],
                                pass: data?.docs[index]['pass'],
                              );
                            },
                          ),
                        );
                      }
                    }

                    // Displaying LoadingSpinner to indicate waiting state
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },

                  // Future that needs to be resolved
                  // inorder to display something on the Canvas
                  future: getNotes(),
                ),
              ],
            ),
          );
        },
      ),
    );
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
