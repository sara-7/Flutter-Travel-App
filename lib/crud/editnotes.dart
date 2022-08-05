import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel_now_app/screens/ComplaintSecreen.dart';
import 'package:travel_now_app/widgets/alert.dart';
import 'package:travel_now_app/widgets/app_bar.dart';
import 'package:travel_now_app/widgets/app_text_field.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({Key? key, this.docid, this.list}) : super(key: key);
  final docid;
  final list;

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  Reference? ref;

  File? file;

  var title, note, imageurl;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  editNotes(context) async {
    var formdata = formstate.currentState;

    if (file == null) {
      //    if (file == null)
      //   return AwesomeDialog(
      //       context: context,
      //       title: "هام",
      //       body: Text("الرجاء اختيار صورة"),
      //       dialogType: DialogType.ERROR)
      //     ..show();
      // var formdata = formstate.currentState;
      if (formdata!.validate()) {
        showLoading(context);
        formdata.save();
        await notesref.doc(widget.docid).update({
          "title": title,
          "note": note,
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
    } else {
      if (formdata!.validate()) {
        showLoading(context);
        formdata.save();
        await ref!.putFile(file!);
        imageurl = await ref!.getDownloadURL();
        await notesref.doc(widget.docid).update({
          "title": title,
          "note": note,
          "imageurl": imageurl,
        }).then((value) {
          //Navigator.of(context).pushNamed("homepage");
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(
        title: 'تعديل شكوى',
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
                  initialValue: widget.list['title'],
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
                  //   decoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: Colors.white,
                  //       labelText: ' عنوان الشكوى',
                  //
                  //     prefixIcon: Icon(Icons.note)),
                  decoration: InputDecoration(
                      focusedBorder: outlineBorder(
                        color: Colors.brown,
                      ),
                      prefixIcon: Icon(Icons.checklist_rtl_rounded,
                          color: Colors.brown),
                      hintText: ' عنوان الشكوى',
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1))),
                ),
                TextFormField(
                  initialValue: widget.list['note'],
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
                  // decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     labelText: "الشكوى",
                  //     prefixIcon: Icon(Icons.note)),
                  decoration: InputDecoration(
                      focusedBorder: outlineBorder(
                        color: Colors.brown,
                      ),
                      prefixIcon: Icon(Icons.checklist_rtl_rounded,
                          color: Colors.brown),
                      hintText: "الشكوى",
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1))),
                ),
                RaisedButton(
                  onPressed: () {
                    showBottomSheet(context);
                  },
                  textColor: Colors.white,
                  color: Colors.brown,
                  child: Text("عدل الصورة"),
                ),
                RaisedButton(
                  onPressed: () async {
                    await editNotes(context);
                  },
                  textColor: Colors.white,
                  color: Colors.brown,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Text(
                    "عدل الشكوى",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ]))
        ],
      )),
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
                  "عدل الصورة",
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
