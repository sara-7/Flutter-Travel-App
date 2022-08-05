import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_now_app/screens/AboutusSecreen.dart';
import 'package:travel_now_app/screens/CategorieSecreen.dart';
import 'package:travel_now_app/screens/ComplaintSecreen.dart';
//import 'package:travel_now_app/screens/HotelScreen.dart';
import 'package:travel_now_app/screens/LoginSecreen.dart';
import 'package:travel_now_app/screens/SupportSecreen.dart';
import 'package:travel_now_app/screens/favorite_list.dart';
import 'package:travel_now_app/screens/favorite_page.dart';

class myDrawer extends StatelessWidget {
  const myDrawer({Key? key}) : super(key: key);
  Future logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  DrawerHeader(
                    child: ListTile(
                      // leading: Image(image: AssetImage("assets/images/profile.png")),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/qalaa.png',
                        ),
                      ),
                      title: Text(
                        'sara ',
                        style: TextStyle(
                          color: Colors.brown,
                        ),
                      ),
                      subtitle: Text(
                        '00972595725136',
                        style: TextStyle(
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.account_balance_rounded,
                      color: Colors.brown,
                      size: 35,
                    ),
                    title: Text("الفنادق"),
                    onTap: () {
                      //Navigator.pushNamed(context, aboutus.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteList(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.favorite_border,
                      color: Colors.brown,
                      size: 35,
                    ),
                    title: Text("المفضلة"),
                    onTap: () {
                      //Navigator.pushNamed(context, bakeries.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoritPage(),
                        ),
                      );
                    },
                  ),

                  // ListTile(
                  //   leading: Icon(
                  //     Icons.person,
                  //     color: Colors.brown,
                  //     size: 35,
                  //   ),
                  //   title: Text("الدعم الفني"),
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => SupportSecreen(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: Colors.brown,
                      size: 35,
                    ),
                    title: Text("نبذة عنا"),
                    onTap: () {
                      //Navigator.pushNamed(context, aboutus.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutusSecreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: Colors.brown,
                      size: 35,
                    ),
                    title: Text("الشكاوي"),
                    onTap: () {
                      //Navigator.pushNamed(context, aboutus.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComplaintSecreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.brown,
                      size: 35,
                    ),
                    title: Text("تسجيل خروج"),
                    onTap: () async {
                      // Navigator.pushNamed(context, login.id);
                      await FirebaseAuth.instance.signOut();
                      logout();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginSecreen(),
                        ),
                      );
                      // Navigator.of(context).pushReplacementNamed("login");
                    },
                  ),

                  //add more drawer menu here
                ],
              ))),
    );
  }
}
