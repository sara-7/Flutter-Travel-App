import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:travel_now_app/crud/addnotes.dart';
import 'package:travel_now_app/models/favorite_list_model.dart';
import 'package:travel_now_app/models/favorite_page_model.dart';
import 'package:travel_now_app/screens/AboutusSecreen.dart';
import 'package:travel_now_app/screens/CategorieSecreen.dart';
import 'package:travel_now_app/screens/ComplaintSecreen.dart';

import 'package:travel_now_app/screens/HomeSecreen.dart';

import 'package:travel_now_app/screens/LoginSecreen.dart';

import 'package:travel_now_app/screens/SignupSecreen.dart';
import 'package:travel_now_app/screens/SupportSecreen.dart';
import 'package:travel_now_app/screens/emailVerification.dart';
import 'package:travel_now_app/screens/favorite_list.dart';
import 'package:travel_now_app/screens/favorite_page.dart';

bool islogin = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp().then((value) {
    var email = preferences.getString("email");
    if (email == null) {
      islogin = false;
    } else {
      islogin = true;
    }

    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => FavoriteListModel(),
        ),
        ChangeNotifierProxyProvider<FavoriteListModel, FavoritPageModel>(
            create: (context) => FavoritPageModel(),
            update: (context, favoritelise, favoritpage) {
              if (favoritpage == null)
                throw ArgumentError.notNull('favoritpage');
              favoritpage.favoriteList = favoritelise;
              return favoritpage;
            }),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'), // English, no country code
        ],
        debugShowCheckedModeBanner: false,
        home: islogin == false ? LoginSecreen() : MainScreen(),
        theme: ThemeData(
            primaryColor: Colors.brown,
            buttonColor: Colors.brown,
            textTheme: TextTheme(
              headline6: TextStyle(fontSize: 20, color: Colors.white),
              headline5: TextStyle(fontSize: 30, color: Colors.blue),
              bodyText2: TextStyle(fontSize: 20, color: Colors.black),
            )),
        routes: {
          LoginSecreen.id: (context) => LoginSecreen(),
          SignupSecreen.id: (context) => SignupSecreen(),
          MainScreen.id: (context) => MainScreen(),
          //DetailsSecreen.id: (context) => DetailsSecreen(),
          SupportSecreen.id: (context) => SupportSecreen(),
          AboutusSecreen.id: (context) => AboutusSecreen(),
          ComplaintSecreen.id: (context) => ComplaintSecreen(),
          //HotelScreen.id: (context) => HotelScreen(),
          //MothafSecreen.id: (context) => MothafSecreen(),
          FavoriteList.id: (context) => FavoriteList(),
          AddNotes.id: (context) => AddNotes(),
          CategorieSecreen.id: (context) => CategorieSecreen(),
          emailVerification.id: (context) => emailVerification(),
          FavoritPage.id: (context) => FavoritPage(),
        },
      ),
    );
  }
}
