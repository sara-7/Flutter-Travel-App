// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:travel_now_app/screens/MothafSecreen.dart';
// import 'package:travel_now_app/screens/HomeSecreen.dart';
// import 'package:travel_now_app/widgets/app_bar.dart';

// class HotelScreen extends StatefulWidget {
//   static const id = 'HotelScreen';
//   const HotelScreen({Key? key}) : super(key: key);

//   @override
//   State<HotelScreen> createState() => _HotelScreenState();
// }

// class _HotelScreenState extends State<HotelScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: [
//         Locale('ar', 'AE'), // English, no country code
//         //Locale('es', ''), // Spanish, no country code
//       ],
//       home: Scaffold(
//         extendBodyBehindAppBar: true,
//         backgroundColor: Colors.grey.shade100,
//         appBar: MyAppBar(
//           title: 'الفنادق',
//           backgroundColor: Colors.transparent,
//           loading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.brown,
//               ),
//               onPressed: () {
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => MainScreen(),
//   ),
// );
//               }),
//         ),
//         body: ListView(
//           shrinkWrap: true,
//           scrollDirection: Axis.vertical,
//           children: <Widget>[
//             SizedBox(
//               height: 30,
//             ),
//             vlist('assets/images/aila.png', 'فندق المتحف',
//                 'www.families.bakeries.com', context),
//             SizedBox(height: 10.0),
//             vlist('assets/images/yaz.png', 'فندق اليازجي',
//                 'www.families.bakeries.com', context),
//             SizedBox(height: 10.0),
//             vlist('assets/images/dhshan.png', 'فندق الدهشان',
//                 'www.families.bakeries.com', context),
//             SizedBox(height: 10.0),
//             vlist('assets/images/qalaa.png', 'فندق القلعة',
//                 'www.families.bakeries.com', context),
//             SizedBox(height: 10.0),
//             vlist('assets/images/shnty.png', 'فندق الشنطي',
//                 'www.families.bakeries.com', context),
//             SizedBox(height: 10.0),
//             vlist('assets/images/koli.png', 'فندق الخولي',
//                 'www.families.bakeries.com', context),
//             SizedBox(height: 10.0),
//             vlist('assets/images/ajor.png', 'مخبز العجور',
//                 'www.families.bakeries.com', context),
//             SizedBox(height: 10.0),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget vlist(String img, String name, String link, BuildContext context) {
//     return Card(
//       margin: EdgeInsets.only(left: 20, right: 20),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 5.0,

//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => MothafSecreen()),
//           );
//         },
//         child: Container(
//           height: 110.0,
//           width: 100,
//           padding: EdgeInsets.all(20),
//           child: Row(
//             children: <Widget>[
//               SizedBox(
//                 width: 10,
//               ),
//               Image(image: AssetImage(img)),
//               SizedBox(
//                 width: 20,
//               ),
//               Column(
//                 children: <Widget>[
//                   Text(
//                     name,
//                     style: TextStyle(
//                       color: Colors.brown,
//                     ),
//                   ),
//                   RatingBar.builder(
//                     initialRating: 4,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     itemCount: 5,
//                     itemSize: 20.0,
//                     itemPadding: EdgeInsets.symmetric(horizontal: .1),
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                       print(rating);
//                     },
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     link,
//                     style: TextStyle(
//                       color: Colors.black54,
//                       fontSize: 7,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.white,
//           ),
//         ),
//       ),
//       // ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_now_app/models/favorites.dart';
import 'package:travel_now_app/screens/FavoriteScreen.dart';

class HotelScreen extends StatelessWidget {
  static const id = 'HotelScreen';
  //static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Sample'),
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () {
              //Navigator.pushNamed(context, FavoritesPage.routeName);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(),
                ),
              );
            },
            icon: Icon(Icons.favorite_border),
            label: Text('Favorites'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        cacheExtent: 20.0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => ItemTile(index),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(
    this.itemNo,
  );

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<Favorites>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo',
          key: Key('text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: favoritesList.items.contains(itemNo)
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          onPressed: () {
            !favoritesList.items.contains(itemNo)
                ? favoritesList.add(itemNo)
                : favoritesList.remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(favoritesList.items.contains(itemNo)
                    ? 'Added to favorites.'
                    : 'Removed from favorites.'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
