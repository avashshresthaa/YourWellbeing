// To parse this JSON data, do
//
//     final influenza = influenzaFromJson(jsonString);

import 'dart:convert';

Influenza influenzaFromJson(String str) => Influenza.fromJson(json.decode(str));

String influenzaToJson(Influenza data) => json.encode(data.toJson());

class Influenza {
  Influenza({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory Influenza.fromJson(Map<String, dynamic> json) => Influenza(
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
    this.influenzaDetails,
  });

  List<InfluenzaDetail>? influenzaDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        influenzaDetails: List<InfluenzaDetail>.from(
            json["influenza_details"].map((x) => InfluenzaDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "influenza_details":
            List<dynamic>.from(influenzaDetails!.map((x) => x.toJson())),
      };
}

class InfluenzaDetail {
  InfluenzaDetail({
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
  List<InfluenzaDetail>? children;

  factory InfluenzaDetail.fromJson(Map<String, dynamic> json) =>
      InfluenzaDetail(
        id: json["id"],
        content: json["content"],
        contentNe: json["contentNe"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        children: json["children"] == null
            ? null
            : List<InfluenzaDetail>.from(
                json["children"].map((x) => InfluenzaDetail.fromJson(x))),
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
