import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:travel_now_app/screens/HomeSecreen.dart';
import 'package:travel_now_app/screens/LoginSecreen.dart';
import 'package:travel_now_app/screens/emailVerification.dart';
import 'package:travel_now_app/widgets/app_bar.dart';
import 'package:travel_now_app/widgets/app_text_field.dart';
import 'package:travel_now_app/widgets/alert.dart';

class SignupSecreen extends StatefulWidget {
  static const id = 'SignupSecreen';
  const SignupSecreen({Key? key}) : super(key: key);

  @override
  State<SignupSecreen> createState() => _SignupSecreenState();
}

class _SignupSecreenState extends State<SignupSecreen> {
  var myusername, mypassword, myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  signUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();

      try {
        showLoading(context);

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context, title: "Error", body: Text("كلمة المرور ضعيفة"))
            ..show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("الحساب موجود بالفعل لهذا البريد الإلكتروني"))
            ..show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    // localizationsDelegates: [
    //   GlobalMaterialLocalizations.delegate,
    //   GlobalWidgetsLocalizations.delegate,
    //   GlobalCupertinoLocalizations.delegate,
    // ],
    // supportedLocales: [
    //   Locale('ar', 'AE'), // English, no country code
    //   //Locale('es', ''), // Spanish, no country code
    // ],
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(
        title: 'انشاء حساب جديد',
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
                  builder: (context) => LoginSecreen(),
                ),
              );
            }),
      ),
      body: ListView(
        children: [
          SizedBox(height: 5),
          Center(child: Image.asset("assets/images/three.png")),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val) {
                        myusername = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "لا يمكن أن يكون اسم المستخدم أكبر من 100 حرف";
                        }
                        if (val.length < 2) {
                          return "لا يمكن أن يكون اسم المستخدم أقل من حرفين";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          focusedBorder: outlineBorder(
                            color: Colors.brown,
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.brown),
                          hintText: "اسم المستخدم",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.brown,
                          ))),
                    ),
                    SizedBox(height: 20),
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
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.brown,
                          ))),
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
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.brown,
                            ),
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text("إذا كان لديك حساب "),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginSecreen(),
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
                        UserCredential response = await signUp();
                        print("===================");
                        if (response != null) {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .add({"username": myusername, "email": myemail});
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => emailVerification()),
                          );
                        } else {
                          print("Sign Up Faild");
                        }
                        print("===================");
                      },
                      child: Text(
                        "انشاء حساب",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                    ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
