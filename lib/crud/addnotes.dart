import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel_now_app/screens/ComplaintSecreen.dart';
import 'package:travel_now_app/widgets/alert.dart';
import 'package:travel_now_app/widgets/app_bar.dart';
import 'package:travel_now_app/widgets/app_text_field.dart';

class AddNotes extends StatefulWidget {
  static const id = 'AddNotes';
  AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  Reference? ref;

  File? file;

  var title, note, imageurl;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  addNotes(context) async {
    if (file == null)
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: Text("الرجاء اختيار صورة"),
          dialogType: DialogType.ERROR)
        ..show();
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      showLoading(context);
      formdata.save();
      await ref?.putFile(file!);
      imageurl = await ref?.getDownloadURL();
      await notesref.add({
        "title": title,
        "note": note,
        "imageurl": imageurl,
        "userid": FirebaseAuth.instance.currentUser!.uid
      }).then((value) {
        // Navigator.of(context).pushNamed("homepage");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComplaintSecreen(),
          ),
        );
      }).catchError((e) {
        print("$e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(
        title: 'اضافة شكوى',
        backgroundColor: Colors.transparent,
        loading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.brown,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComplaintSecreen(),
                ),
              );
            }),
      ),
      // body: Container(
      //   margin: EdgeInsets.all(8.0),
      //   child: Column(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Form(
                key: formstate,
                child: Column(children: [
                  TextFormField(
                    validator: (val) {
                      if (val!.length > 30) {
                        return "لا يمكن أن يكون العنوان أكبر من 30 حرفًا";
                      }
                      if (val.length < 2) {
                        return "لا يمكن أن يكون العنوان أقل من حرفين";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      title = val;
                    },
                    maxLength: 30,
                    decoration: InputDecoration(
                        focusedBorder: outlineBorder(
                          color: Colors.brown,
                        ),
                        prefixIcon: Icon(Icons.checklist_rtl_rounded,
                            color: Colors.brown),
                        hintText: ' عنوان الشكوى',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (val) {
                      if (val!.length > 255) {
                        return "لا يمكن أن تكون الشكوى أكبر من 255 حرفًا";
                      }
                      if (val.length < 10) {
                        return "لا يمكن أن تكون الشكوى أقل من 10 أحرف";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      note = val;
                    },
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 200,
                    decoration: InputDecoration(
                        focusedBorder: outlineBorder(
                          color: Colors.brown,
                        ),
                        prefixIcon: Icon(Icons.checklist_rtl_rounded,
                            color: Colors.brown),
                        hintText: "الشكوى",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.brown,
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    textColor: Colors.white,
                    child: Text("اضف صورة"),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      await addNotes(context);
                    },
                    color: Colors.brown,
                    textColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    child: Text(
                      "اضافة الشكوى",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 192,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "الرجاء اختيار صورة",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    var picked = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("$imagename");

                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_outlined,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "من المعرض",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () async {
                    var picked = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("$imagename");
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "من الكاميرا",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        });
  }
}
