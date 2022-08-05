import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_now_app/models/favorite_list_model.dart';
import 'package:travel_now_app/models/favorite_page_model.dart';
import 'package:travel_now_app/screens/HomeSecreen.dart';
import 'package:travel_now_app/screens/favorite_page.dart';
import 'package:travel_now_app/widgets/app_bar.dart';

class FavoriteList extends StatelessWidget {
  static const id = 'FavoriteList';
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      appBar: MyAppBar(
        title: 'الفنادق',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritPage()),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          //2
          // SliverAppBar(
          //   title: Text(
          //     'favorite',
          //   ),
          //   floating: true,
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.favorite_border),
          //     onPressed: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => FavoritPage()),
          //     ),
          //   )
          // ],
          // ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
            ),
          ),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext, int index) {
                return _MyListItem(index);
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;
  const _MyListItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<FavoriteListModel, Item>(
      (FavoriteList) => FavoriteList.getByPosition(index),
    );
    //var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 60,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(item.imge),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            // _AddButton(item: item),
            _AddButton(item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  const _AddButton(@required this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInFavoritPage = context.select<FavoritPageModel, bool>(
      (favoritepage) => favoritepage.items.contains(item),
    );
    return IconButton(
      icon: isInFavoritPage
          ? Icon(Icons.favorite, color: Colors.red)
          : Icon(Icons.favorite_border),
      onPressed: isInFavoritPage
          ? () {
              var favoritepage = context.read<FavoritPageModel>();
              favoritepage.remove(item);
            }
          : () {
              var favoritepage = context.read<FavoritPageModel>();
              favoritepage.add(item);
            },
    );
  }
}
