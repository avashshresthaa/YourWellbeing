import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yourwellbeing/APIModels/getContacts.dart';

class NetworkHelper {
  //Fetching Contact API

  var baseUrl = 'http://10.0.2.2:80';

  Future<Contacts> getContactsData() async {
    var contactModel;
    http.Response response = await http.get(
      Uri.parse('$baseUrl/fypapi/public/api/contacts'),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('success');
      var data = response.body;
      var jsonMap = jsonDecode(data);
      contactModel = Contacts.fromJson(jsonMap);
      print(data);
    }
    return contactModel;
  }
}
