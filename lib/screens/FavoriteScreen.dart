// import 'package:flutter/material.dart';

// class FavoriteScreen extends StatefulWidget {
//   static const id = 'FavoriteScreen';
//   const FavoriteScreen({Key? key}) : super(key: key);

//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }

// class _FavoriteScreenState extends State<FavoriteScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("FavoriteScreen"),
//     );
//   }
// }

////////////////////////////////////////////////////
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:path/path.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// //import 'package:travel_now_app/widgets/alert.dart';

// class FavoriteScreen extends StatefulWidget {
//   static const id = 'FavoriteScreen';
//   const FavoriteScreen({Key? key}) : super(key: key);

//   @override
//   _FavoriteScreenState createState() => _FavoriteScreenState();
// }

// class _FavoriteScreenState extends State<FavoriteScreen> {
//   File? file;
//   var ImgePker = ImagePicker();

//   uploadimg() async {
//     var ImgePkered = await ImgePker.getImage(source: ImageSource.gallery);
//     if (ImgePkered != null) {
//       file = File(ImgePkered.path);
//       var nameimg = basename(ImgePkered.path);
//       var ref = FirebaseStorage.instance.ref("myimg/$nameimg");
//       await ref.putFile(file!);
//       var url = ref.getDownloadURL();
//       print("**************************");
//       print("url :$url");
//     } else {
//       print("pleas choose img");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Note'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text("enter imge"),
//           onPressed: () async {
//             await uploadimg();
//           },
//         ),
//       ),

//     );
//   }

// }

///////////////////////////////////////////////////////////////
///
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_now_app/models/favorites.dart';
//import 'package:testing_app/models/favorites.dart';

class FavoriteScreen extends StatelessWidget {
  static const id = 'FavoriteScreen';
  //static String routeName = '/favorites_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Consumer<Favorites>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.items.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => FavoriteItemTile(value.items[index]),
        ),
      ),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  final int itemNo;

  const FavoriteItemTile(
    this.itemNo,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo',
          key: Key('favorites_text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('remove_icon_$itemNo'),
          icon: Icon(Icons.close),
          onPressed: () {
            Provider.of<Favorites>(context, listen: false).remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Removed from favorites.'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
