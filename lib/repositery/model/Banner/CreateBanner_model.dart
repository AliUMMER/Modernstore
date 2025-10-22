// To parse this JSON data, do
//
//     final createBannerModel = createBannerModelFromJson(jsonString);

import 'dart:convert';

CreateBannerModel createBannerModelFromJson(String str) =>
    CreateBannerModel.fromJson(json.decode(str));

String createBannerModelToJson(CreateBannerModel data) =>
    json.encode(data.toJson());

class CreateBannerModel {
  bool success;
  Banner banner;

  CreateBannerModel({
    required this.success,
    required this.banner,
  });

  factory CreateBannerModel.fromJson(Map<String, dynamic> json) =>
      CreateBannerModel(
        success: json["success"],
        banner: Banner.fromJson(json["banner"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "banner": banner.toJson(),
      };
}

class Banner {
  List<String> images;
  String title;
  String category;
  String type;
  dynamic productId;
  String categoryId;
  String link;
  String id;
  int v;

  Banner({
    required this.images,
    required this.title,
    required this.category,
    required this.type,
    required this.productId,
    required this.categoryId,
    required this.link,
    required this.id,
    required this.v,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        images: List<String>.from(json["images"].map((x) => x)),
        title: json["title"],
        category: json["category"],
        type: json["type"],
        productId: json["productId"],
        categoryId: json["categoryId"],
        link: json["link"],
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "title": title,
        "category": category,
        "type": type,
        "productId": productId,
        "categoryId": categoryId,
        "link": link,
        "_id": id,
        "__v": v,
      };
}
