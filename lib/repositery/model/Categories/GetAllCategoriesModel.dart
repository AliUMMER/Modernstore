import 'dart:convert';

GetAllCategoriesModel getAllCategoriesModelFromJson(String str) => 
    GetAllCategoriesModel.fromJson(json.decode(str));

String getAllCategoriesModelToJson(GetAllCategoriesModel data) => 
    json.encode(data.toJson());

class GetAllCategoriesModel {
    bool success;
    List<Category> categories;

    GetAllCategoriesModel({
        required this.success,
        required this.categories,
    });

    factory GetAllCategoriesModel.fromJson(Map<String, dynamic> json) => 
        GetAllCategoriesModel(
            success: json["success"] ?? false,
            categories: json["categories"] != null
                ? List<Category>.from(
                    json["categories"].map((x) => Category.fromJson(x)))
                : [],
        );

    Map<String, dynamic> toJson() => {
        "success": success,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    String id;
    String name;
    String description;
    String image;
    int v;

    Category({
        required this.id,
        required this.name,
        required this.description,
        required this.image,
        required this.v,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        description: json["description"] ?? "Default description", // Direct string
        image: json["image"] ?? "",
        v: json["__v"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "image": image,
        "__v": v,
    };
}