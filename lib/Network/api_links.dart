import 'dart:convert';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:yourwellbeing/APIModels/getContacts.dart';
import 'package:yourwellbeing/APIModels/getCovid.dart';
import 'package:yourwellbeing/APIModels/getInfluenza.dart';

import 'NetworkHelper.dart';

class ApiData {
  //Fetching Contact API
  // For emulator url http://10.0.2.2:80

  var wifibaseUrl = 'http://192.168.40.182';
  var baseUrl = 'http://10.0.2.2:80';
  Future<Contacts> getApiContactDetails() async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("contact_numbers");
    if (!isCacheExist) {
      var jsonData =
          await NetworkHelper().getData('$baseUrl/fypapi/public/api/contacts');

      //create database for contact_numbers where json data is stored
      APICacheDBModel cacheDBModel =
          new APICacheDBModel(key: "contact_numbers", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      var contactModel = Contacts.fromJson(jsonMap);
      print("url : hit");
      return contactModel;
      //If the data is already there
    } else {
      var cacheData = await APICacheManager().getCacheData("contact_numbers");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hit");
      return Contacts.fromJson(jsonMap);
    }
  }

  Future<Covid> getApiCovidDetails() async {
    var isCacheExist = await APICacheManager().isAPICacheKeyExist("covid");
    if (!isCacheExist) {
      var jsonData =
          await NetworkHelper().getData('$baseUrl/fypapi/public/api/covid');

      //create database for contact_numbers where json data is stored
      APICacheDBModel cacheDBModel =
          new APICacheDBModel(key: "covid", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      var covidModel = Covid.fromJson(jsonMap);
      print("url : hit");
      return covidModel;
      //If the data is already there
    } else {
      var cacheData = await APICacheManager().getCacheData("covid");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hit");
      return Covid.fromJson(jsonMap);
    }
  }

  Future<Influenza> getApiInfluenzaDetails() async {
    var isCacheExist = await APICacheManager().isAPICacheKeyExist("influenza");
    if (!isCacheExist) {
      var jsonData =
          await NetworkHelper().getData('$baseUrl/fypapi/public/api/influenza');

      //create database for contact_numbers where json data is stored
      APICacheDBModel cacheDBModel =
          new APICacheDBModel(key: "influenza", syncData: jsonData);
      await APICacheManager().addCacheData(cacheDBModel);
      var jsonMap = jsonDecode(jsonData);
      var influenzaModel = Influenza.fromJson(jsonMap);
      print("url : hit");
      return influenzaModel;
      //If the data is already there
    } else {
      var cacheData = await APICacheManager().getCacheData("influenza");
      var jsonMap = jsonDecode(cacheData.syncData);
      print("cache: hit");
      return Influenza.fromJson(jsonMap);
    }
  }

  Future downloadData() async {
    await getApiContactDetails();
    await getApiCovidDetails();
    await getApiInfluenzaDetails();
  }

  Future updateContent() async {
    await APICacheManager().emptyCache();
    await downloadData();
    print("Updated everything");
  }
}
