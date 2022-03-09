// To parse this JSON data, do
//
//     final contacts = contactsFromJson(jsonString);

import 'dart:convert';

Contacts contactsFromJson(String str) => Contacts.fromJson(json.decode(str));

String contactsToJson(Contacts data) => json.encode(data.toJson());

class Contacts {
  Contacts({
    this.message,
    this.data,
  });

  String? message;
  List<Datum>? data;

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.location,
    this.name,
    this.number,
  });

  int? id;
  String? location;
  String? name;
  String? number;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        location: json["location"],
        name: json["name"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "name": name,
        "number": number,
      };
}
