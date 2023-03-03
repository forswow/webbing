
import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static late SharedPreferences _prefs;
  factory Pref() => Pref._internal();
  Pref._internal();

  static Future<void> init() async =>
      _prefs = await SharedPreferences.getInstance();
  static set setUrl(String url) => _prefs.setString('url', url);
  static String get getUrl => _prefs.getString('url') ?? '';
}
