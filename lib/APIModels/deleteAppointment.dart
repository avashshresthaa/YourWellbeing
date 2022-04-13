// To parse this JSON data, do
//
//     final deleteData = deleteDataFromJson(jsonString);

import 'dart:convert';

DeleteData deleteDataFromJson(String str) =>
    DeleteData.fromJson(json.decode(str));

String deleteDataToJson(DeleteData data) => json.encode(data.toJson());

class DeleteData {
  DeleteData({
    this.message,
  });

  String? message;

  factory DeleteData.fromJson(Map<String, dynamic> json) => DeleteData(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
