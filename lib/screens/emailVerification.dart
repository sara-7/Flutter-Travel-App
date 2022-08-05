import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'HomeSecreen.dart';

class emailVerification extends StatefulWidget {
  static const id = 'emailVerfication';

  const emailVerification({Key? key}) : super(key: key);

  @override
  State<emailVerification> createState() => _emailVerificationState();
}

class _emailVerificationState extends State<emailVerification> {
  final _auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;
  void initState() {
    user = _auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 20), (timer) {
      checkEmailVerfied();
    });

    super.initState();
  }

  Future<void> checkEmailVerfied() async {
    user = _auth.currentUser!;
    await user.reload();
    if (user != null && user.emailVerified) {
      timer.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
        appBar: AppBar(
          title: Text("email Verification"),
        ),
        body: Center(
          child: Text(
            "please go to ${user.email} to verfiy your acount",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}
