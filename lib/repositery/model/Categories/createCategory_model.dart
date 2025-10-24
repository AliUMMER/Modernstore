// To parse this JSON data, do
//
//     final createCategoryModel = createCategoryModelFromJson(jsonString);

import 'dart:convert';

CreateCategoryModel createCategoryModelFromJson(String str) => CreateCategoryModel.fromJson(json.decode(str));

String createCategoryModelToJson(CreateCategoryModel data) => json.encode(data.toJson());

class CreateCategoryModel {
    bool success;
    Category category;

    CreateCategoryModel({
        required this.success,
        required this.category,
    });

    factory CreateCategoryModel.fromJson(Map<String, dynamic> json) => CreateCategoryModel(
        success: json["success"],
        category: Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "category": category.toJson(),
    };
}

class Category {
    String name;
    String description;
    String image;
    String id;
    int v;

    Category({
        required this.name,
        required this.description,
        required this.image,
        required this.id,
        required this.v,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        description: json["description"],
        image: json["image"],
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "image": image,
        "_id": id,
        "__v": v,
    };
}
