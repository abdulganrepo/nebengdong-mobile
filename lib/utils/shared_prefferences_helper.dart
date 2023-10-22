import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPrefs? _instance;
  static SharedPreferences? _sharedPreferences;

  static const String kToken = "token";

  static Future<SharedPrefs?> getInstance() async {
    if (_instance == null) {
      _instance = SharedPrefs();
    }
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  // token key =================================================================
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kToken) ?? null;
  }

  static Future<bool> setToken(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kToken, value!);
  }
}
