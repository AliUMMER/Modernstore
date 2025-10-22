// To parse this JSON data, do
//
//     final getAllBannerModel = getAllBannerModelFromJson(jsonString);

import 'dart:convert';

GetAllBannerModel getAllBannerModelFromJson(String str) => GetAllBannerModel.fromJson(json.decode(str));

String getAllBannerModelToJson(GetAllBannerModel data) => json.encode(data.toJson());

class GetAllBannerModel {
    bool success;
    List<Banner> banners;

    GetAllBannerModel({
        required this.success,
        required this.banners,
    });

    factory GetAllBannerModel.fromJson(Map<String, dynamic> json) => GetAllBannerModel(
        success: json["success"],
        banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    };
}

class Banner {
    String id;
    List<String> images;
    Title title;
    Category category;
    Type type;
    dynamic productId;
    CategoryId categoryId;
    Link link;
    int v;

    Banner({
        required this.id,
        required this.images,
        required this.title,
        required this.category,
        required this.type,
        required this.productId,
        required this.categoryId,
        required this.link,
        required this.v,
    });

    factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        title: titleValues.map[json["title"]]!,
        category: categoryValues.map[json["category"]]!,
        type: typeValues.map[json["type"]]!,
        productId: json["productId"],
        categoryId: CategoryId.fromJson(json["categoryId"]),
        link: linkValues.map[json["link"]]!,
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "title": titleValues.reverse[title],
        "category": categoryValues.reverse[category],
        "type": typeValues.reverse[type],
        "productId": productId,
        "categoryId": categoryId.toJson(),
        "link": linkValues.reverse[link],
        "__v": v,
    };
}

enum Category {
    HOME
}

final categoryValues = EnumValues({
    "home": Category.HOME
});

class CategoryId {
    Id id;
    Name name;

    CategoryId({
        required this.id,
        required this.name,
    });

    factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: idValues.map[json["_id"]]!,
        name: nameValues.map[json["name"]]!,
    );

    Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "name": nameValues.reverse[name],
    };
}

enum Id {
    THE_67_EC290_ADAA2_FB3_CD2_AF3_A2_A
}

final idValues = EnumValues({
    "67ec290adaa2fb3cd2af3a2a": Id.THE_67_EC290_ADAA2_FB3_CD2_AF3_A2_A
});

enum Name {
    VEGITABLES
}

final nameValues = EnumValues({
    "Vegitables": Name.VEGITABLES
});

enum Link {
    NULL
}

final linkValues = EnumValues({
    "null": Link.NULL
});

enum Title {
    TESTING
}

final titleValues = EnumValues({
    "Testing": Title.TESTING
});

enum Type {
    CATEGORY
}

final typeValues = EnumValues({
    "category": Type.CATEGORY
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
