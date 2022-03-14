// To parse this JSON data, do
//
//     final covid = covidFromJson(jsonString);

import 'dart:convert';

Covid covidFromJson(String str) => Covid.fromJson(json.decode(str));

String covidToJson(Covid data) => json.encode(data.toJson());

class Covid {
  Covid({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory Covid.fromJson(Map<String, dynamic> json) => Covid(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.covidDetails,
  });

  List<CovidDetail>? covidDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        covidDetails: List<CovidDetail>.from(
            json["covid_details"].map((x) => CovidDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "covid_details":
            List<dynamic>.from(covidDetails!.map((x) => x.toJson())),
      };
}

class CovidDetail {
  CovidDetail({
    this.id,
    this.content,
    this.contentNe,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.children,
  });

  int? id;
  String? content;
  String? contentNe;
  int? parentId;
  dynamic createdAt;
  dynamic updatedAt;
  List<CovidDetail>? children;

  factory CovidDetail.fromJson(Map<String, dynamic> json) => CovidDetail(
        id: json["id"],
        content: json["content"],
        contentNe: json["contentNe"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        children: json["children"] == null
            ? null
            : List<CovidDetail>.from(
                json["children"].map((x) => CovidDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "contentNe": contentNe,
        "parent_id": parentId == null ? null : parentId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}
