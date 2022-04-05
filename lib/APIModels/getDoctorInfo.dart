// To parse this JSON data, do
//
//     final doctorInfo = doctorInfoFromJson(jsonString);

import 'dart:convert';

List<DoctorInfo> doctorInfoFromJson(String str) =>
    List<DoctorInfo>.from(json.decode(str).map((x) => DoctorInfo.fromJson(x)));

String doctorInfoToJson(List<DoctorInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorInfo {
  DoctorInfo({
    this.id,
    this.name,
    this.nameNe,
    this.speciality,
    this.specialityNe,
    this.ratings,
    this.ratingSNe,
    this.experience,
    this.experienceNe,
    this.about,
    this.aboutNe,
    this.appointmentTime,
    this.appointmentTimeNe,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? nameNe;
  String? speciality;
  String? specialityNe;
  String? ratings;
  String? ratingSNe;
  String? experience;
  String? experienceNe;
  String? about;
  String? aboutNe;
  String? appointmentTime;
  String? appointmentTimeNe;
  String? email;
  dynamic createdAt;
  dynamic updatedAt;

  factory DoctorInfo.fromJson(Map<String, dynamic> json) => DoctorInfo(
        id: json["id"],
        name: json["name"],
        nameNe: json["nameNe"],
        speciality: json["speciality"],
        specialityNe: json["specialityNe"],
        ratings: json["ratings"],
        ratingSNe: json["ratingSNe"],
        experience: json["experience"],
        experienceNe: json["experienceNe"],
        about: json["about"],
        aboutNe: json["aboutNe"],
        appointmentTime: json["appointmentTime"],
        appointmentTimeNe: json["appointmentTimeNe"],
        email: json["email"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nameNe": nameNe,
        "speciality": speciality,
        "specialityNe": specialityNe,
        "ratings": ratings,
        "ratingSNe": ratingSNe,
        "experience": experience,
        "experienceNe": experienceNe,
        "about": about,
        "aboutNe": aboutNe,
        "appointmentTime": appointmentTime,
        "appointmentTimeNe": appointmentTimeNe,
        "email": email,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
