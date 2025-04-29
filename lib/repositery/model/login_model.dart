class Login {
  bool? success;
  User? user;
  String? accessToken;

  Login({this.success, this.user, this.accessToken});

  Login.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["accessToken"] is String) {
      accessToken = json["accessToken"];
    }
  }

  static List<Login> fromList(List<Map<String, dynamic>> list) {
    return list.map(Login.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["accessToken"] = accessToken;
    return _data;
  }
}

class User {
  String? id;
  dynamic name;
  String? phoneNumber;
  dynamic email;
  dynamic profileImage;
  String? role;
  List<String>? userDlvAddresses;
  String? createdAt;
  String? updatedAt;
  int? v;

  User(
      {this.id,
      this.name,
      this.phoneNumber,
      this.email,
      this.profileImage,
      this.role,
      this.userDlvAddresses,
      this.createdAt,
      this.updatedAt,
      this.v});

  User.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    name = json["name"];
    if (json["phoneNumber"] is String) {
      phoneNumber = json["phoneNumber"];
    }
    email = json["email"];
    profileImage = json["profileImage"];
    if (json["role"] is String) {
      role = json["role"];
    }
    if (json["userDlvAddresses"] is List) {
      userDlvAddresses = json["userDlvAddresses"] == null
          ? null
          : List<String>.from(json["userDlvAddresses"]);
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

  static List<User> fromList(List<Map<String, dynamic>> list) {
    return list.map(User.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["phoneNumber"] = phoneNumber;
    _data["email"] = email;
    _data["profileImage"] = profileImage;
    _data["role"] = role;
    if (userDlvAddresses != null) {
      _data["userDlvAddresses"] = userDlvAddresses;
    }
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
