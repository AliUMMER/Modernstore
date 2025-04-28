class GetByIdProduct {
  bool? success;
  Data? data;

  GetByIdProduct({this.success, this.data});

  GetByIdProduct.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  static List<GetByIdProduct> fromList(List<Map<String, dynamic>> list) {
    return list.map(GetByIdProduct.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  String? id;
  String? name;
  String? description;
  String? details;
  List<String>? images;
  String? category;
  int? basePrice;
  int? discountPercentage;
  String? unit;
  String? sku;
  String? slug;
  String? createdAt;
  String? updatedAt;
  int? v;

  Data(
      {this.id,
      this.name,
      this.description,
      this.details,
      this.images,
      this.category,
      this.basePrice,
      this.discountPercentage,
      this.unit,
      this.sku,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.v});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["details"] is String) {
      details = json["details"];
    }
    if (json["images"] is List) {
      images =
          json["images"] == null ? null : List<String>.from(json["images"]);
    }
    if (json["category"] is String) {
      category = json["category"];
    }
    if (json["basePrice"] is int) {
      basePrice = json["basePrice"];
    }
    if (json["discountPercentage"] is int) {
      discountPercentage = json["discountPercentage"];
    }
    if (json["unit"] is String) {
      unit = json["unit"];
    }
    if (json["sku"] is String) {
      sku = json["sku"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["details"] = details;
    if (images != null) {
      _data["images"] = images;
    }
    _data["category"] = category;
    _data["basePrice"] = basePrice;
    _data["discountPercentage"] = discountPercentage;
    _data["unit"] = unit;
    _data["sku"] = sku;
    _data["slug"] = slug;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
