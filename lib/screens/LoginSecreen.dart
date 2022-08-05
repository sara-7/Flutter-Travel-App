import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:travel_now_app/screens/HomeSecreen.dart';
import 'package:travel_now_app/screens/SignupSecreen.dart';
import 'package:travel_now_app/widgets/app_text_field.dart';
import 'package:travel_now_app/widgets/alert.dart';

class LoginSecreen extends StatefulWidget {
  static const id = 'LoginSecreen';
  const LoginSecreen({Key? key}) : super(key: key);

  @override
  State<LoginSecreen> createState() => _LoginSecreenState();
}

class _LoginSecreenState extends State<LoginSecreen> {
  var mypassword, myemail;
  var emmail;
  final _auth = FirebaseAuth.instance;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  signIn() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("لم يتم العثور على مستخدم لهذا البريد الإلكتروني"))
            ..show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("تم توفير كلمة مرور خاطئة لهذا المستخدم"))
            ..show();
        }
      }
    } else {
      print("غير صالح");
    }
  }

  Future savelogin() async {
    User? user = FirebaseAuth.instance.currentUser;
    emmail = user!.email;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("email", emmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              alignment: Alignment(1.0, 1.0),
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'تسجيل الدخول ',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.brown),
              ),
            ),
            Center(
              child: Image.asset("assets/images/one.png"),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (val) {
                          myemail = val;
                        },
                        validator: (val) {
                          if (val!.length > 100) {
                            return "لا يمكن أن يكون البريد الإلكتروني أكبر من 100 حرف";
                          }
                          if (val.length < 2) {
                            return "لا يمكن أن يكون البريد الإلكتروني أقل من حرفين";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            focusedBorder: outlineBorder(
                              color: Colors.brown,
                            ),
                            prefixIcon:
                                Icon(Icons.email_rounded, color: Colors.brown),
                            hintText: "البريد الإلكتروني",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        onSaved: (val) {
                          mypassword = val;
                        },
                        validator: (val) {
                          if (val!.length > 100) {
                            return "لا يمكن أن تكون كلمة المرور أكبر من 100 حرف";
                          }
                          if (val.length < 4) {
                            return "لا يمكن أن تكون كلمة المرور أقل من 4 أحرف";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            focusedBorder: outlineBorder(
                              color: Colors.brown,
                            ),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.brown,
                            ),
                            hintText: "كلمة المرور",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text("إذا لم يكن لديك حساب "),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupSecreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "انقر هنا",
                                  style: TextStyle(color: Colors.brown),
                                ),
                              )
                            ],
                          )),
                      Container(
                          child: RaisedButton(
                        color: Colors.brown,
                        textColor: Colors.white,
                        onPressed: () async {
                          var user = await signIn();

                          if (user != null) {
                            savelogin();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "تسجيل الدخول",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                      ))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
