// To parse this JSON data, do
//
//     final beritaInsertModel = beritaInsertModelFromJson(jsonString);

import 'dart:convert';

BeritaInsertModel beritaInsertModelFromJson(String str) => BeritaInsertModel.fromJson(json.decode(str));

String beritaInsertModelToJson(BeritaInsertModel data) => json.encode(data.toJson());

class BeritaInsertModel {
  bool isSuccess;
  String message;

  BeritaInsertModel({
    required this.isSuccess,
    required this.message,
  });

  factory BeritaInsertModel.fromJson(Map<String, dynamic> json) => BeritaInsertModel(
    isSuccess: json["is_success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "message": message,
  };
}
