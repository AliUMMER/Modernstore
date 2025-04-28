class GetUserDlvAddresses {
  bool? success;
  String? message;
  List<Data>? data;

  GetUserDlvAddresses({this.success, this.message, this.data});

  GetUserDlvAddresses.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }

  static List<GetUserDlvAddresses> fromList(List<Map<String, dynamic>> list) {
    return list.map(GetUserDlvAddresses.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String? id;
  UserId? userId;
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
    if (json["userId"] is Map) {
      userId = json["userId"] == null ? null : UserId.fromJson(json["userId"]);
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
    if (userId != null) {
      _data["userId"] = userId?.toJson();
    }
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

class UserId {
  String? id;
  dynamic name;
  String? phoneNumber;
  dynamic email;

  UserId({this.id, this.name, this.phoneNumber, this.email});

  UserId.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    name = json["name"];
    if (json["phoneNumber"] is String) {
      phoneNumber = json["phoneNumber"];
    }
    email = json["email"];
  }

  static List<UserId> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserId.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["phoneNumber"] = phoneNumber;
    _data["email"] = email;
    return _data;
  }
}
