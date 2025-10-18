import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();

  ////factory constructor to return singleton instance
  factory PreferencesManager() {
    return _instance;
  }
  late final SharedPreferences _preferences;
  PreferencesManager._internal();
  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  Future<bool> setSInt(String key, int value) async {
    return _preferences.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return _preferences.setDouble(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  List<String>? getStringList(String key) {
    return _preferences.getStringList(key);
  }

  remove(key) async {
    await _preferences.remove(key);
  }
  clear() async {
    await _preferences.clear();
  }
}
