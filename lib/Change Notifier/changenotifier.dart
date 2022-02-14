import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class DataProvider extends ChangeNotifier {
  late bool data;
  late bool language;

  //Initial data is true which is english. If the data is already in shared preference then
  //it will choose accordingly
  DataProvider() {
    data = true;
    loadFromPrefs();
  }

  void changeString(bool newString) async {
    data = newString;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getBool('chooseLanguage')!;
    notifyListeners();
  }

  loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getBool('languageData')!;
    notifyListeners();
  }
}
