import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future createCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("password", password);
  }

  Future readCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("password");
    return cache;
  }

  Future removeCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("password");
  }
}
