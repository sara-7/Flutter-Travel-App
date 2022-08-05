import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_now_app/models/favorite_list_model.dart';
import 'package:travel_now_app/models/favorite_page_model.dart';
import 'package:travel_now_app/screens/HomeSecreen.dart';
import 'package:travel_now_app/screens/favorite_list.dart';
import 'package:travel_now_app/widgets/app_bar.dart';

class FavoritPage extends StatelessWidget {
  static const id = 'FavoritPage';
  // const FavoritPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey.shade100,
        appBar: MyAppBar(
          title: ' الفنادق المفضلة',
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
                    builder: (context) => FavoriteList(),
                  ),
                );
              }),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: _FavoritePageList(),
                ),
              ),
            ],
          ),
        ));
  }
}

class _FavoritePageList extends StatelessWidget {
  //const _FavoritePageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var itemNameStyle = Theme.of(context).textTheme.headline6;
    var favoritepage = context.watch<FavoritPageModel>();

    return ListView.builder(
        itemCount: favoritepage.items.length,
        itemBuilder: (context, index) => ListTile(
              leading: Image.asset(favoritepage.items[index].imge),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  favoritepage.remove(favoritepage.items[index]);
                },
              ),
              title: Text(
                favoritepage.items[index].name,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.brown,
                ),
              ),
              subtitle: Text(
                favoritepage.items[index].subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ));
  }
}
