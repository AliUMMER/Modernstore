
class GetAllBannerModel {
  bool? success;
  List<Banners>? banners;

  GetAllBannerModel({this.success, this.banners});

  GetAllBannerModel.fromJson(Map<String, dynamic> json) {
    if(json["success"] is bool) {
      success = json["success"];
    }
    if(json["banners"] is List) {
      banners = json["banners"] == null ? null : (json["banners"] as List).map((e) => Banners.fromJson(e)).toList();
    }
  }

  static List<GetAllBannerModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(GetAllBannerModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if(banners != null) {
      _data["banners"] = banners?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Banners {
  String? id;
  List<String>? images;
  String? title;
  String? category;
  String? type;
  dynamic productId;
  CategoryId? categoryId;
  String? link;
  int? v;

  Banners({this.id, this.images, this.title, this.category, this.type, this.productId, this.categoryId, this.link, this.v});

  Banners.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["images"] is List) {
      images = json["images"] == null ? null : List<String>.from(json["images"]);
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["category"] is String) {
      category = json["category"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    productId = json["productId"];
    if(json["categoryId"] is Map) {
      categoryId = json["categoryId"] == null ? null : CategoryId.fromJson(json["categoryId"]);
    }
    if(json["link"] is String) {
      link = json["link"];
    }
    if(json["__v"] is int) {
      v = json["__v"];
    }
  }

  static List<Banners> fromList(List<Map<String, dynamic>> list) {
    return list.map(Banners.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    if(images != null) {
      _data["images"] = images;
    }
    _data["title"] = title;
    _data["category"] = category;
    _data["type"] = type;
    _data["productId"] = productId;
    if(categoryId != null) {
      _data["categoryId"] = categoryId?.toJson();
    }
    _data["link"] = link;
    _data["__v"] = v;
    return _data;
  }
}

class CategoryId {
  String? id;
  String? name;

  CategoryId({this.id, this.name});

  CategoryId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
  }

  static List<CategoryId> fromList(List<Map<String, dynamic>> list) {
    return list.map(CategoryId.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    return _data;
  }
}