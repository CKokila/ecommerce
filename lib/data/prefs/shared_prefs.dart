import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs ?? await SharedPreferences.getInstance();
  }

  static setString(String key, String value) async => await _prefs?.setString(key, value);


  static getString(String key) => _prefs?.getString(key) ?? '';

  static setStringList(String key, List<String> value) async => await _prefs?.setStringList(key, value);

  static List<String>? getStringList(String key) => _prefs?.getStringList(key) ?? <String>[];

  static setBool(String key, bool value) async => await _prefs?.setBool(key, value);
//bool getBool(String key,bool defaultValue) => _prefs?.getBool(key) ?? defaultValue;
  static getBool(String key) => _prefs?.getBool(key);
}
