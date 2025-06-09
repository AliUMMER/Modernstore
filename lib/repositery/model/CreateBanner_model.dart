
class CreateBannerModel {
  bool? success;
  Banner? banner;

  CreateBannerModel({this.success, this.banner});

  CreateBannerModel.fromJson(Map<String, dynamic> json) {
    if(json["success"] is bool) {
      success = json["success"];
    }
    if(json["banner"] is Map) {
      banner = json["banner"] == null ? null : Banner.fromJson(json["banner"]);
    }
  }

  static List<CreateBannerModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(CreateBannerModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if(banner != null) {
      _data["banner"] = banner?.toJson();
    }
    return _data;
  }
}

class Banner {
  List<String>? images;
  String? title;
  String? category;
  String? type;
  dynamic productId;
  String? categoryId;
  String? link;
  String? id;
  int? v;

  Banner({this.images, this.title, this.category, this.type, this.productId, this.categoryId, this.link, this.id, this.v});

  Banner.fromJson(Map<String, dynamic> json) {
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
    if(json["categoryId"] is String) {
      categoryId = json["categoryId"];
    }
    if(json["link"] is String) {
      link = json["link"];
    }
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["__v"] is int) {
      v = json["__v"];
    }
  }

  static List<Banner> fromList(List<Map<String, dynamic>> list) {
    return list.map(Banner.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(images != null) {
      _data["images"] = images;
    }
    _data["title"] = title;
    _data["category"] = category;
    _data["type"] = type;
    _data["productId"] = productId;
    _data["categoryId"] = categoryId;
    _data["link"] = link;
    _data["_id"] = id;
    _data["__v"] = v;
    return _data;
  }
}