class UpdateDeliveryAddress {
  bool? success;
  String? message;
  Data? data;

  UpdateDeliveryAddress({this.success, this.message, this.data});

  UpdateDeliveryAddress.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  static List<UpdateDeliveryAddress> fromList(List<Map<String, dynamic>> list) {
    return list.map(UpdateDeliveryAddress.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  String? id;
  String? userId;
  String? address;
  String? city;
  String? pincode;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  int? v;

  Data(
      {this.id,
      this.userId,
      this.address,
      this.city,
      this.pincode,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.v});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
    if (json["city"] is String) {
      city = json["city"];
    }
    if (json["pincode"] is String) {
      pincode = json["pincode"];
    }
    if (json["latitude"] is String) {
      latitude = json["latitude"];
    }
    if (json["longitude"] is String) {
      longitude = json["longitude"];
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
    _data["userId"] = userId;
    _data["address"] = address;
    _data["city"] = city;
    _data["pincode"] = pincode;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
