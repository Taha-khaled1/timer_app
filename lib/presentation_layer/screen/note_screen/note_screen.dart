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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            backgroundColor: ColorManager.background,
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            isScrollControlled: true, // Added this line
            builder: (BuildContext context) {
              return Container(
                height: 640,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context)
                        .viewInsets
                        .bottom, // Adjust for keyboard
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  child: ListView(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Title',
                          style: MangeStyles().getBoldStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onChanged: (p0) {
                          title = p0.toString();
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: ColorManager.fillColor,
                          labelText: 'Title',
                          hintStyle: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 14,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                            letterSpacing: 0.20,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Notes',
                          style: MangeStyles().getBoldStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      TextFormField(
                        onChanged: (p0) {
                          message = p0.toString();
                        },
                        minLines: 5,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: ColorManager.fillColor,
                          labelText: 'Description',
                          hintStyle: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 14,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                            letterSpacing: 0.20,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      isNoteLoad
                          ? CircularProgressIndicator(
                              color: ColorManager.kPrimary,
                            )
                          : CustomButton(
                              width: double.infinity,
                              haigh: 60,
                              color: ColorManager.kPrimary,
                              text: 'Create New Note',
                              press: () async {
                                if (message.isEmpty || title.isEmpty) {
                                  showToast('There are some empty fields');
                                } else {
                                  isNoteLoad = true;
                                  // setState(() {});
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
                                  Get.back();
                                  showToast('Note added successfully');
                                  setState(() {});
                                }
                              },
                              rectangel: 25,
                            ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: ColorManager.kPrimary,
      ),
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
                          child: ListView.builder(
                            itemCount: data?.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return NoteCard(
                                des: data?.docs[index]['note'],
                                title: data?.docs[index]['title'],
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
