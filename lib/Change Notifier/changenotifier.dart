import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class DataProvider extends ChangeNotifier {
  var otherName;
  late var tokenValue;
/*  bool data = true;
  var language;
  var login;*/

  //Initial data is true which is english. If the data is already in shared preference then
  //it will choose accordingly
  DataProvider() {
/*    data = true;
    loadFromPrefs();*/
  }

  void getOtherName(String username) {
    otherName = username;
    notifyListeners();
  }

  void token(var token) {
    tokenValue = token;
    print("tokenvalue: $tokenValue");
    notifyListeners();
  }
}
