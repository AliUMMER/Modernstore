
class GetAllUserCartModel {
  bool? success;
  Data? data;

  GetAllUserCartModel({this.success, this.data});

  GetAllUserCartModel.fromJson(Map<String, dynamic> json) {
    if(json["success"] is bool) {
      success = json["success"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  static List<GetAllUserCartModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(GetAllUserCartModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  int? totalCartLength;
  double? totalCartAmount;
  List<AllCartItems>? allCartItems;

  Data({this.totalCartLength, this.totalCartAmount, this.allCartItems});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["totalCartLength"] is int) {
      totalCartLength = json["totalCartLength"];
    }
    if(json["totalCartAmount"] is double) {
      totalCartAmount = json["totalCartAmount"];
    }
    if(json["AllCartItems"] is List) {
      allCartItems = json["AllCartItems"] == null ? null : (json["AllCartItems"] as List).map((e) => AllCartItems.fromJson(e)).toList();
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["totalCartLength"] = totalCartLength;
    _data["totalCartAmount"] = totalCartAmount;
    if(allCartItems != null) {
      _data["AllCartItems"] = allCartItems?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class AllCartItems {
  String? id;
  String? userId;
  ProductId? productId;
  int? quantity;
  String? unit;
  double? totalAmount;
  String? createdAt;
  String? updatedAt;
  int? v;

  AllCartItems({this.id, this.userId, this.productId, this.quantity, this.unit, this.totalAmount, this.createdAt, this.updatedAt, this.v});

  AllCartItems.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["userId"] is String) {
      userId = json["userId"];
    }
    if(json["productId"] is Map) {
      productId = json["productId"] == null ? null : ProductId.fromJson(json["productId"]);
    }
    if(json["quantity"] is int) {
      quantity = json["quantity"];
    }
    if(json["unit"] is String) {
      unit = json["unit"];
    }
    if(json["totalAmount"] is double) {
      totalAmount = json["totalAmount"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if(json["__v"] is int) {
      v = json["__v"];
    }
  }

  static List<AllCartItems> fromList(List<Map<String, dynamic>> list) {
    return list.map(AllCartItems.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["userId"] = userId;
    if(productId != null) {
      _data["productId"] = productId?.toJson();
    }
    _data["quantity"] = quantity;
    _data["unit"] = unit;
    _data["totalAmount"] = totalAmount;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class ProductId {
  String? id;
  String? name;

  ProductId({this.id, this.name});

  ProductId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
  }

  static List<ProductId> fromList(List<Map<String, dynamic>> list) {
    return list.map(ProductId.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    return _data;
  }
}