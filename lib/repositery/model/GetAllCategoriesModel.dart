class GetAllCategoriesModel {
  bool? success;
  List<Categories>? categories;

  GetAllCategoriesModel({this.success, this.categories});

  GetAllCategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["categories"] is List) {
      categories = json["categories"] == null
          ? null
          : (json["categories"] as List)
              .map((e) => Categories.fromJson(e))
              .toList();
    }
  }

  static List<GetAllCategoriesModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(GetAllCategoriesModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if (categories != null) {
      _data["categories"] = categories?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Categories {
  String? id;
  String? name;
  String? description;
  String? image;
  int? v;

  Categories({this.id, this.name, this.description, this.image, this.v});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
  }

  static List<Categories> fromList(List<Map<String, dynamic>> list) {
    return list.map(Categories.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["image"] = image;
    _data["__v"] = v;
    return _data;
  }
}
