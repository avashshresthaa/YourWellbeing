// To parse this JSON data, do
//
//     final createAppointment = createAppointmentFromJson(jsonString);

import 'dart:convert';

CreateAppointment createAppointmentFromJson(String str) =>
    CreateAppointment.fromJson(json.decode(str));

String createAppointmentToJson(CreateAppointment data) =>
    json.encode(data.toJson());

class CreateAppointment {
  CreateAppointment({
    this.message,
  });

  String? message;

  factory CreateAppointment.fromJson(Map<String, dynamic> json) =>
      CreateAppointment(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
