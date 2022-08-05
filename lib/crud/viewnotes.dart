import 'package:flutter/material.dart';
import 'package:travel_now_app/screens/ComplaintSecreen.dart';
import 'package:travel_now_app/widgets/app_bar.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({Key? key, this.notes}) : super(key: key);
  final notes;

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(
        title: 'عرض الشكوى',
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
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Container(
                child: Image.network(
              "${widget.notes['imageurl']}",
              width: double.infinity,
              height: 300,
              fit: BoxFit.fill,
            )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "${widget.notes['title']}",
                  style: Theme.of(context).textTheme.headline5,
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "${widget.notes['note']}",
                  style: Theme.of(context).textTheme.bodyText2,
                )),
          ],
        ),
      ),
    );
  }
}
