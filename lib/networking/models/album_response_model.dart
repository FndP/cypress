// To parse this JSON data, do
//
//     final albumResponseModel = albumResponseModelFromJson(jsonString);

import 'dart:convert';

List<AlbumResponseModel> albumResponseModelFromJson(List value) =>
    List<AlbumResponseModel>.from(
        value.map((x) => AlbumResponseModel.fromJson(x)));

String albumResponseModelToJson(List<AlbumResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlbumResponseModel {
  AlbumResponseModel({
    this.userId,
    this.id,
    this.title,
  });

  int? userId;
  int? id;
  String? title;

  factory AlbumResponseModel.fromJson(Map<String, dynamic> json) =>
      AlbumResponseModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
