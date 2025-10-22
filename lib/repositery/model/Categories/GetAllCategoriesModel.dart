// To parse this JSON data, do
//
//     final getAllCategoriesModel = getAllCategoriesModelFromJson(jsonString);

import 'dart:convert';

GetAllCategoriesModel getAllCategoriesModelFromJson(String str) => GetAllCategoriesModel.fromJson(json.decode(str));

String getAllCategoriesModelToJson(GetAllCategoriesModel data) => json.encode(data.toJson());

class GetAllCategoriesModel {
    bool success;
    List<Category> categories;

    GetAllCategoriesModel({
        required this.success,
        required this.categories,
    });

    factory GetAllCategoriesModel.fromJson(Map<String, dynamic> json) => GetAllCategoriesModel(
        success: json["success"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    String id;
    String name;
    Description description;
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
        id: json["_id"],
        name: json["name"],
        description: descriptionValues.map[json["description"]]!,
        image: json["image"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": descriptionValues.reverse[description],
        "image": image,
        "__v": v,
    };
}

enum Description {
    DEFAULT_DESCRIPTION,
    NOTHING,
    NOTHING_MUCH,
    TESTING_ONLY_DESCRIPTION
}

final descriptionValues = EnumValues({
    "Default description": Description.DEFAULT_DESCRIPTION,
    "nothing": Description.NOTHING,
    "nothing much": Description.NOTHING_MUCH,
    "Testing only description": Description.TESTING_ONLY_DESCRIPTION
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
