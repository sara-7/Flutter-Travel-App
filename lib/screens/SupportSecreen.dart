import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_now_app/screens/HomeSecreen.dart';
import 'package:travel_now_app/widgets/app_bar.dart';
import 'package:travel_now_app/widgets/app_text_field.dart';

class SupportSecreen extends StatefulWidget {
  static const id = 'SupportSecreen';
  const SupportSecreen({Key? key}) : super(key: key);

  @override
  State<SupportSecreen> createState() => _SupportSecreenState();
}

class _SupportSecreenState extends State<SupportSecreen> {
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
      color: Colors.grey,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey.shade100,
        appBar: MyAppBar(
          title: "الدعم الفني",
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
        body: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),

                //1
                Container(
                  margin: EdgeInsets.fromLTRB(8.0, 30.0, 8.0,
                      8.0), //حدود لكل الكونتينبر يعني لكل الي بداخلها
                  child: Image.asset("assets/images/sigiup.png"),
                ),
                //2
                AppTextField(
                  hintText: 'اسم المستخدم',
                  keyboardType: TextInputType.emailAddress,
                  //textInputAction: TextInputAction.name,
                  prefixIcon: Icons.person,
                ),
                //3
                SizedBox(height: 5.0),
                AppTextField(
                  hintText: 'البريد الالكتروني او رقم الجوال',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.email_rounded,
                ),
                SizedBox(height: 5.0),
                //4
                AppTextField(
                  hintText: 'الموضوع:',
                  keyboardType: TextInputType.text,
                  //textInputAction: TextInputAction.name,
                  prefixIcon: Icons.checklist_rtl_rounded,
                ),

                SizedBox(height: 5.0),
                //5
                AppTextField(
                  hintText: 'المشكلة:',
                  hintMaxLines: 5,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  //textInputAction: TextInputAction.name,
                  prefixIcon: Icons.checklist_rtl_rounded,
                ),

                SizedBox(height: 5.0),
                ////////////////////////////////////////////////////////////////////
                //buttom
                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  height: 45.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.blueGrey,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: RaisedButton(
                        onPressed: () => setState(() {
                          Navigator.pushNamed(context, MainScreen.id);
                          //str = mycontroller.text;
                        }),
                        color: Colors.brown,
                        child: Center(
                          child: Text(
                            'ارسال الطلب',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
