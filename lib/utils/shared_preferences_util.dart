import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  // Method to clear all data stored in SharedPreferences
  static Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
