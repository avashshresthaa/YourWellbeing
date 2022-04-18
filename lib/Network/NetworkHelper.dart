import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yourwellbeing/APIModels/createAppointment.dart';
import 'package:yourwellbeing/APIModels/deleteAppointment.dart';
import 'package:yourwellbeing/APIModels/getAppointments.dart';
import 'package:yourwellbeing/APIModels/getContacts.dart';
import 'package:yourwellbeing/APIModels/getCovid.dart';
import 'package:yourwellbeing/APIModels/getDoctorAppointments.dart';
import 'package:yourwellbeing/APIModels/getDoctorInfo.dart';
import 'package:yourwellbeing/APIModels/getLogin.dart';
import 'package:yourwellbeing/APIModels/getLogout.dart';
import 'package:yourwellbeing/APIModels/getRegister.dart';

class NetworkHelper {
  //All downloadable function API call this function
  Future<dynamic> getData(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        /*'Bearer 6033fee8-fd94-11eb-9a03-0242ac130003'*/
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = response.body;

        return data;
      }
    } catch (Exception) {}
  }

  //Fetching Contact API
  var wifibaseUrl = 'http://192.168.40.182';
  var baseUrl = 'http://192.168.137.1';

/*  Future<Covid> getCovidData() async {
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
  }*/

  Future<DoctorInfo> getDoctorInfoData() async {
    var doctorModel;
    http.Response response = await http.get(
      Uri.parse('$baseUrl/fypapi/public/api/doctorinfo'),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('success');
      var data = response.body;
      var jsonMap = jsonDecode(data);
      doctorModel = DoctorInfo.fromJson(jsonMap);
      print(data);
    }
    return doctorModel;
  }

  Future<List<DoctorInfo>> getDoctor(String query) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/fypapi/public/api/doctorinfo'),
    );
    if (response.statusCode == 200) {
      final List books = json.decode(response.body);
      return books.map((json) => DoctorInfo.fromJson(json)).where((book) {
        final titleLower = book.name!.toLowerCase();
        final specialLower = book.speciality!.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            specialLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<Login> getLoginData(
    String email,
    String password,
  ) async {
    var loginModel;
    http.Response response = await http.post(
      Uri.parse('$baseUrl/fypapi/public/api/login'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(<dynamic, dynamic>{
        'email': email,
        'password': password,
      }),
    );

//print(response.statusCode);
    if (response.statusCode == 200) {
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("login: $jsonMap");
      loginModel = Login.fromJson(jsonMap);
    }
    return loginModel;
  }

  Future<Register> getRegData(
    String name,
    String email,
    String password,
  ) async {
    var registerModel;
    http.Response response = await http.post(
      Uri.parse('$baseUrl/fypapi/public/api/register'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("Register: $jsonMap");
      registerModel = Register.fromJson(jsonMap);
    } else if (response.statusCode == 201) {
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("Register: $jsonMap");
      registerModel = Register.fromJson(jsonMap);
    }
    return registerModel;
  }

  Future<Logout> getLogoutData(var token) async {
    var logoutModel;
    http.Response response = await http.post(
        Uri.parse('$baseUrl/fypapi/public/api/logout'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var data = response.body;

      var jsonMap = jsonDecode(data);
      logoutModel = Logout.fromJson(jsonMap);
      print(jsonMap);
    }
    return logoutModel;
  }

  Future<CreateAppointment>? createAppointment(
    String name,
    String age,
    String gender,
    String phone,
    String datetime,
    String doctorName,
    String hospitalName,
    String describeProblem,
    String payment,
    var token,
  ) async {
    var createModel;
    http.Response response = await http.post(
      Uri.parse('$baseUrl/fypapi/public/api/appointment/add'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'age': age,
        'gender': gender,
        'phone': phone,
        'datetime': datetime,
        'doctorName': doctorName,
        'hospitalName': hospitalName,
        'describeProblem': describeProblem,
        'payment': payment,
      }),
    );
    print(response.statusCode);
    print("not ok");

    if (response.statusCode == 200) {
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("Register: $jsonMap");
      createModel = CreateAppointment.fromJson(jsonMap);
    }
    return createModel;
  }

  Future<AppointmentDetails>? getAppointmentDetails(var token) async {
    var doctorModel;
    http.Response response = await http.get(
      Uri.parse('$baseUrl/fypapi/public/api/appointments'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('success');
      var data = response.body;
      var jsonMap = jsonDecode(data);
      doctorModel = AppointmentDetails.fromJson(jsonMap);
      print(data);
    }
    return doctorModel;
  }

  Future<DeleteData?> deleteAppointmentData(String url, var token) async {
    var deleteModel;

    try {
      http.Response response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        var data = response.body;

        var jsonMap = jsonDecode(data);
        deleteModel = DeleteData.fromJson(jsonMap);
        print(data);
      }
      return deleteModel;
    } catch (e) {}
  }

  Future<AppointmentDoctorDetails>? getDoctorAppointmentDetails(
      var token) async {
    var doctorModel;
    http.Response response = await http.get(
      Uri.parse('$baseUrl/fypapi/public/api/doctorappointments'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('success');
      var data = response.body;
      var jsonMap = jsonDecode(data);
      doctorModel = AppointmentDoctorDetails.fromJson(jsonMap);
      print(data);
    }
    return doctorModel;
  }
}
