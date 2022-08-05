// import 'package:flutter/material.dart';
// import 'package:travel_now_app/screens/HomeSecreen.dart';
// import 'package:travel_now_app/screens/LoginSecreen.dart';
// import 'package:travel_now_app/services/shared_preferences_service.dart';
// import 'dart:async';
// //import 'package:sharedpreftutorial/services/shared_preferences_service.dart';

// class SplashSecreen extends StatefulWidget {
//   static const id = 'SplashSecreen';
//   const SplashSecreen({Key? key}) : super(key: key);

//   @override
//   State<SplashSecreen> createState() => _SplashSecreenState();
// }

// class _SplashSecreenState extends State<SplashSecreen> {
//   final PrefService _prefService = PrefService();

//   @override
//   void initState() {
//     _prefService.readCache("password").then((value) {
//       print(value.toString());
//       if (value != null) {
//         return Timer(Duration(seconds: 2),
//             () => Navigator.pushNamed(context, MainScreen.id));
//       } else {
//         return Timer(Duration(seconds: 2),
//             () => Navigator.pushNamed(context, LoginSecreen.id));
//       }
//     });
//     super.initState();
//   }
//   // @override
//   // void initState() {
//   //   Future.delayed(const Duration(seconds: 3), () {
//   //     Navigator.pushNamed(context, LoginSecreen.id);
//   //   });

//   //   // TODO: implement initState
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         //appBar: AppBar(title: Text("AppBar title"), ),
//         body: Container(
//           // color: b,
//           // height: double.infinity,
//           alignment: Alignment.center,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 //1

//                 Container(
//                   alignment: Alignment.center,
//                   // child: Image.network(
//                   //     'https://images.unsplash.com/photo-1501555088652-021faa106b9b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1473&q=80'),
//                   child: Image.asset("assets/images/two.png"),
//                   height: 400,
//                   width: 400,
//                 ),
//                 SizedBox(width: 5.0),
//                 Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.only(
//                     top: 15.0,
//                     bottom: 15.0,
//                   ),
//                   child: Text(
//                     'تطبيق للسياحة والسفر ',
//                     style: TextStyle(
//                         fontFamily: 'Montserrat',
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20.0,
//                         color: Colors.brown),
//                   ),
//                 ),
//                 SizedBox(width: 5.0),
//                 //2
//                 Container(
//                   alignment: Alignment.center,
//                   //padding: EdgeInsets.only(left: 20.0),
//                   child: Text(
//                     ' اذا كنت من محبي السفر \n  سيوفر لك هذا التطبيق اجمل الخيارات لخوض تجارب جديدة\n بالاضافة لاقتراحات لاجمل الفنادق وكل تفاصيلها',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontFamily: 'Montserrat',
//                         //fontWeight: FontWeight.bold,
//                         fontSize: 10.0,
//                         color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
