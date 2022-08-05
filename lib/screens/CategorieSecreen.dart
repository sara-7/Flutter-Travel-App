import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_now_app/screens/HomeSecreen.dart';
import 'package:travel_now_app/screens/ViewAreaSecreen.dart';
import 'package:travel_now_app/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel_now_app/widgets/app_drawer.dart';

class CategorieSecreen extends StatefulWidget {
  static const id = 'CategorieSecreen';
  const CategorieSecreen({Key? key}) : super(key: key);

  @override
  State<CategorieSecreen> createState() => _CategorieSecreenState();
}

class _CategorieSecreenState extends State<CategorieSecreen> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("areas");

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
        drawer: myDrawer(),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey.shade100,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'الى اين',
                    style: TextStyle(
                      fontFamily: 'Opensans',
                      fontSize: 50.0,
                      color: Colors.brown,
                    ),
                  ),
                  Text(
                    'ستسافر اليوم؟',
                    style: TextStyle(
                      fontFamily: 'Opensans',
                      fontSize: 50.0,
                    ),
                  ),
                  // Text(
                  //   'اليوم',
                  //   style: TextStyle(
                  //     fontFamily: 'Opensans',
                  //     fontSize: 50.0,
                  //   ),
                  // )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                height: 70.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xFFF9F9F9)),
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      hintText: 'ماذا تريد ان تكتشف؟',
                      hintStyle: TextStyle(
                          fontFamily: 'Opensans',
                          fontSize: 15.0,
                          color: Colors.grey.withOpacity(0.7)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('الاكثر شيوعا',
                        style: TextStyle(
                          fontFamily: 'Opensans',
                          fontSize: 20.0,
                        )),
                    Icon(Icons.more_horiz, color: Colors.black)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                height: 300.0,
                child: StreamBuilder<QuerySnapshot>(
                    stream: notesref.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              return ListNotes(
                                notes: snapshot.data!.docs[i],
                                docid: snapshot.data!.docs[i].id,
                              );
                            });
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ),
          ],
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
          return ViewAreaSecreen(notes: notes);
        }));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Stack(
            children: <Widget>[
              Container(
                height: 275.0,
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: NetworkImage("${notes['image']}"),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: 275.0,
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.black.withOpacity(0.4)),
              ),
              Positioned(
                top: 10.0,
                left: 10.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black.withOpacity(0.2)),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.white, size: 12.0),
                          SizedBox(width: 5.0),
                          Text(
                            "${notes['rate']}",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                    ),
                    SizedBox(width: 50.0),
                    Text(
                      'تفاصيل',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Opensans'),
                    ),
                    SizedBox(width: 7.0),
                    //this should be an iconbutton in a real app.
                    Icon(Icons.arrow_drop_down, color: Colors.white, size: 25.0)
                  ],
                ),
              ),
              Positioned(
                top: 165.0,
                left: 10.0,
                child: Container(
                  width: 150.0,
                  child: Text("${notes['name']}",
                      style: TextStyle(
                          fontFamily: 'Opensans',
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Positioned(
                top: 200.0,
                left: 10.0,
                child: Container(
                  width: 150.0,
                  child: Text("${notes['site']}",
                      style: TextStyle(
                          fontFamily: 'Opensans',
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
