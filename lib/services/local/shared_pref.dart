
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesHelper> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesHelper();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Set a boolean value
  Future<void> setBool(String key, bool value) async {
    if (_preferences != null) {
      await _preferences!.setBool(key, value);
    }
  }

  // Get a boolean value
  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences?.getBool(key) ?? defaultValue;
  }
}
