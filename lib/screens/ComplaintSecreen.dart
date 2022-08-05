import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_now_app/crud/addnotes.dart';
import 'package:travel_now_app/crud/editnotes.dart';
import 'package:travel_now_app/crud/viewnotes.dart';
import 'package:travel_now_app/screens/HomeSecreen.dart';
import 'package:travel_now_app/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ComplaintSecreen extends StatefulWidget {
  static const id = 'ComplaintSecreen';
  const ComplaintSecreen({Key? key}) : super(key: key);

  @override
  State<ComplaintSecreen> createState() => _ComplaintSecreenState();
}

class _ComplaintSecreenState extends State<ComplaintSecreen> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'), // English, no country code
        //Locale('es', ''), // Spanish, no country code
      ],
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey.shade100,
        appBar: MyAppBar(
          title: 'الشكاوي',
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
                    builder: (context) => MainScreen(),
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.brown,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNotes(),
                ),
              );
            }),
        body: Container(
          // child: FutureBuilder(
          //     future: notesref.where("userid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
          child: StreamBuilder<QuerySnapshot>(
              stream: notesref.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,

                      //Histories histories = snapshot.data![index];
                      itemBuilder: (context, i) {
                        return Dismissible(
                            onDismissed: (diretion) async {
                              await notesref
                                  .doc(snapshot.data!.docs[i].id)
                                  .delete();
                              await FirebaseStorage.instance
                                  .refFromURL(
                                      snapshot.data!.docs[i]['imageurl'])
                                  .delete()
                                  .then((value) {
                                print("=================================");
                                print("Delete");
                              });
                            },
                            key: UniqueKey(),
                            child: ListNotes(
                              notes: snapshot.data!.docs[i],
                              docid: snapshot.data!.docs[i].id,
                            ));
                      });
                }
                return Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}

class ListNotes extends StatelessWidget {
  final notes;
  final docid;
  ListNotes({this.notes, this.docid});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ViewNote(notes: notes);
        }));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "${notes['imageurl']}",
                fit: BoxFit.fill,
                height: 80,
              ),
            ),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text("${notes['title']}"),
                subtitle: Text(
                  "${notes['note']}",
                  style: TextStyle(fontSize: 14),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return EditNotes(docid: docid, list: notes);
                    }));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.brown,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

  //       body: ListView(
  //         shrinkWrap: true,
  //         scrollDirection: Axis.vertical,
  //         children: <Widget>[
  //           SizedBox(
  //             height: 30,
  //           ),
  //           Complaint('شكوى 1', context),
  //           SizedBox(height: 10.0),
  //           Complaint('شكوى 2', context),
  //           SizedBox(height: 10.0),
  //           Complaint('شكوى 3', context),
  //           SizedBox(height: 10.0),
  //           Complaint('شكوى 4', context),
  //           SizedBox(height: 10.0),
  //           Complaint('شكوى 5', context),
  //           SizedBox(height: 10.0),
  //           Complaint('شكوى 6', context),
  //           SizedBox(height: 10.0),
  //           Complaint('شكوى 7', context),
  //           SizedBox(height: 10.0),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget Complaint(String name, BuildContext context) {
  //   return Card(
  //     margin: EdgeInsets.only(left: 20, right: 20),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     elevation: 5.0,

  //     child: GestureDetector(
  //       onTap: () {
  //         // Navigator.push(context,MaterialPageRoute(builder: (context) => MothafSecreen()),);
  //       },
  //       child: Container(
  //         height: 80.0,
  //         width: 100,
  //         padding: EdgeInsets.all(20),
  //         child: Center(
  //           child: Text(
  //             name,
  //             style: TextStyle(
  //               color: Colors.black54,
  //               fontSize: 20,
  //             ),
  //           ),
  //         ),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //     // ),
  //   );
//   }
// }
