import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyTitle = 'title';
  static const _keyBody = 'body';
  static const _keyTime = 'time';
  static const _keyPurpose = 'choosePreference';
  static const _keyLanguage = 'languageData';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setTitle(String title) async =>
      await _preferences?.setString(_keyTitle, title);

  static String? getTitle() => _preferences?.getString(_keyTitle);

  static Future setBody(String body) async =>
      await _preferences?.setString(_keyBody, body);

  static String? getBody() => _preferences?.getString(_keyBody);

  static Future setTime(String time) async =>
      await _preferences?.setString(_keyTime, time);

  static String? getTime() => _preferences?.getString(_keyTime);

  static String? getLogin() => _preferences?.getString('login');

  static Future setLanguage(bool language) async =>
      await _preferences?.setBool(_keyLanguage, language);

  static bool? getLanguage() => _preferences?.getBool(_keyLanguage);

  static String? getPurpose() => _preferences?.getString(_keyPurpose);
}
