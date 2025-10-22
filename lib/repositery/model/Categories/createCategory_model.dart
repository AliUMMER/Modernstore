class CreateCategoryModel {
  bool? success;
  Category? category;

  CreateCategoryModel({this.success, this.category});

  CreateCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["category"] is Map) {
      category =
          json["category"] == null ? null : Category.fromJson(json["category"]);
    }
  }

  static List<CreateCategoryModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(CreateCategoryModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if (category != null) {
      _data["category"] = category?.toJson();
    }
    return _data;
  }
}

class Category {
  String? name;
  String? description;
  String? image;
  String? id;
  int? v;

  Category({this.name, this.description, this.image, this.id, this.v});

  Category.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
  }

  static List<Category> fromList(List<Map<String, dynamic>> list) {
    return list.map(Category.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["description"] = description;
    _data["image"] = image;
    _data["_id"] = id;
    _data["__v"] = v;
    return _data;
  }
}
