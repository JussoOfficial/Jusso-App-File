import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _prefs;

  static Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUsername(String username) async {
    await _init();
    await _prefs.setString('username', username);
  }

  static Future<String?> getUsername() async {
    await _init();
    return _prefs.getString('username');
  }

  static Future<void> saveBio(String bio) async {
    await _init();
    await _prefs.setString('bio', bio);
  }

  static Future<String?> getBio() async {
    await _init();
    return _prefs.getString('bio');
  }
}
