import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yourwellbeing/APIModels/getContacts.dart';
import 'package:yourwellbeing/APIModels/getCovid.dart';

class NetworkHelper {
  //All downloadable function API call this function
  Future<dynamic> getData(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        /*'Bearer 6033fee8-fd94-11eb-9a03-0242ac130003'*/
      });
      if (response.statusCode == 200) {
        var data = response.body;

        return data;
      }
    } catch (Exception) {}
  }

  //Fetching Contact API
  var wifibaseUrl = 'http://192.168.40.182';
  var baseUrl = 'http://10.0.2.2:80';

  Future<Covid> getCovidData() async {
    var covidModel;
    http.Response response = await http.get(
      Uri.parse('$baseUrl/fypapi/public/api/covid'),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('success');
      var data = response.body;
      var jsonMap = jsonDecode(data);
      covidModel = Covid.fromJson(jsonMap);
      print(data);
    }
    return covidModel;
  }
}
