import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences _sharedPreferences;
  static SharedPreferencesService _sharedPreferencesService;

  SharedPreferencesService._() {}

  static SharedPreferencesService getInstance() {
    if (_sharedPreferencesService == null) {
      _sharedPreferencesService = SharedPreferencesService._();
      _initPreferences();
    }
    return _sharedPreferencesService;
  }

  static Future<SharedPreferencesService> getInstanceAsync() async {
    if (_sharedPreferencesService == null) {
      _sharedPreferencesService = SharedPreferencesService._();
      await _initPreferences();
    }
    return _sharedPreferencesService;
  }


  static _initPreferences() async {
    if (_sharedPreferences == null)
      _sharedPreferences = await SharedPreferences.getInstance();
  }

  void putObject(String key, var value) {
    _sharedPreferences.setString(key, jsonEncode(value));
  }

  Map<String, dynamic> getObject(String key) {
    var result = _sharedPreferences.get(key);

    return result != null ? jsonDecode(result) : null;
  }

  List<dynamic> getObjects(String key) {
    var result = _sharedPreferences.get(key);

    return result != null ? jsonDecode(result) : null;
  }


  void putString(String key, String value) {
    _sharedPreferences.setString(key, value);
  }

  String getString(String key) {
    return _sharedPreferences.getString(key);
  }

  void remove(String key) {
    _sharedPreferences.remove(key);
  }

  void clear() {
    _sharedPreferences.clear();
  }
}
