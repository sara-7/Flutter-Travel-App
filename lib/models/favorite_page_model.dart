import 'package:flutter/foundation.dart';
import 'package:travel_now_app/models/favorite_list_model.dart';
//import 'package:travel_now_app/models/favorites.dart';

class FavoritPageModel extends ChangeNotifier {
  late FavoriteListModel _favoriteList;
  final List<int> _itemIds = [];

  FavoriteListModel get favoriteList => _favoriteList;

  set favoriteList(FavoriteListModel newList) {
    _favoriteList = newList;
    notifyListeners();
  }

  List<Item> get items =>
      _itemIds.map((id) => _favoriteList.getById(id)).toList();

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }
 
  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}
