import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static final PrefUtils instance = PrefUtils._internal();

  PrefUtils._internal();
  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value.isNotEmpty) {
      await prefs.setString(key, value);
    }
  }
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  Future<void> setBoolean(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
  Future<bool> getBoolean(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
