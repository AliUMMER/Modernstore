// To parse this JSON data, do
//
//     final getUserProfile = getUserProfileFromJson(jsonString);

import 'dart:convert';

GetUserProfile getUserProfileFromJson(String str) => GetUserProfile.fromJson(json.decode(str));

String getUserProfileToJson(GetUserProfile data) => json.encode(data.toJson());

class GetUserProfile {
    bool success;
    User user;

    GetUserProfile({
        required this.success,
        required this.user,
    });

    factory GetUserProfile.fromJson(Map<String, dynamic> json) => GetUserProfile(
        success: json["success"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "user": user.toJson(),
    };
}

class User {
    String id;
    dynamic name;
    String phoneNumber;
    dynamic email;
    dynamic profileImage;
    String role;
    List<String> userDlvAddresses;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    User({
        required this.id,
        required this.name,
        required this.phoneNumber,
        required this.email,
        required this.profileImage,
        required this.role,
        required this.userDlvAddresses,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        profileImage: json["profileImage"],
        role: json["role"],
        userDlvAddresses: List<String>.from(json["userDlvAddresses"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "profileImage": profileImage,
        "role": role,
        "userDlvAddresses": List<dynamic>.from(userDlvAddresses.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
