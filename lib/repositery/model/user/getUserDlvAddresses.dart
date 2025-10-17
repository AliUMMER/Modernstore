// To parse this JSON data, do
//
//     final getUserDlvAddresses = getUserDlvAddressesFromJson(jsonString);

import 'dart:convert';

GetUserDlvAddresses getUserDlvAddressesFromJson(String str) => GetUserDlvAddresses.fromJson(json.decode(str));

String getUserDlvAddressesToJson(GetUserDlvAddresses data) => json.encode(data.toJson());

class GetUserDlvAddresses {
    bool success;
    String message;
    List<Datum> data;

    GetUserDlvAddresses({
        required this.success,
        required this.message,
        required this.data,
    });

    factory GetUserDlvAddresses.fromJson(Map<String, dynamic> json) => GetUserDlvAddresses(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    UserId userId;
    Address address;
    City city;
    String pincode;
    String latitude;
    String longitude;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.userId,
        required this.address,
        required this.city,
        required this.pincode,
        required this.latitude,
        required this.longitude,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        address: addressValues.map[json["address"]]!,
        city: cityValues.map[json["city"]]!,
        pincode: json["pincode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "address": addressValues.reverse[address],
        "city": cityValues.reverse[city],
        "pincode": pincode,
        "latitude": latitude,
        "longitude": longitude,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

enum Address {
    ROOT_SYS_SKY_MALL_EDARIKKODE_KOTTAKKAL
}

final addressValues = EnumValues({
    "Root-sys, SkyMall, Edarikkode, Kottakkal": Address.ROOT_SYS_SKY_MALL_EDARIKKODE_KOTTAKKAL
});

enum City {
    EDARIKKODE,
    KOTTAKKAL
}

final cityValues = EnumValues({
    "Edarikkode": City.EDARIKKODE,
    "Kottakkal": City.KOTTAKKAL
});

class UserId {
    Id id;
    dynamic name;
    String phoneNumber;
    dynamic email;

    UserId({
        required this.id,
        required this.name,
        required this.phoneNumber,
        required this.email,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: idValues.map[json["_id"]]!,
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
    };
}

enum Id {
    THE_68067_F36617_C3_D30_A33_E0_FE0
}

final idValues = EnumValues({
    "68067f36617c3d30a33e0fe0": Id.THE_68067_F36617_C3_D30_A33_E0_FE0
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
