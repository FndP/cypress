// To parse this JSON data, do
//
//     final photosResponseModel = photosResponseModelFromJson(jsonString);

import 'dart:convert';

List<PhotosResponseModel> photosResponseModelFromJson(List value) =>
    List<PhotosResponseModel>.from(
        value.map((x) => PhotosResponseModel.fromJson(x)));

String photosResponseModelToJson(List<PhotosResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhotosResponseModel {
  PhotosResponseModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  factory PhotosResponseModel.fromJson(Map<String, dynamic> json) =>
      PhotosResponseModel(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}
