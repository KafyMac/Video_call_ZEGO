// To parse this JSON data, do
//
//     final getMyProfileResp = getMyProfileRespFromJson(jsonString);

import 'dart:convert';

GetMyProfileResp getMyProfileRespFromJson(String str) =>
    GetMyProfileResp.fromJson(json.decode(str));

String getMyProfileRespToJson(GetMyProfileResp data) =>
    json.encode(data.toJson());

class GetMyProfileResp {
  String? status;
  String? message;
  Data? data;

  GetMyProfileResp({
    this.status,
    this.message,
    this.data,
  });

  factory GetMyProfileResp.fromJson(Map<String, dynamic> json) =>
      GetMyProfileResp(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  User? user;
  List<String>? otherUsersFcmTokens;

  Data({
    this.user,
    this.otherUsersFcmTokens,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        otherUsersFcmTokens: json["otherUsersFcmTokens"] == null
            ? []
            : List<String>.from(json["otherUsersFcmTokens"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "otherUsersFcmTokens": otherUsersFcmTokens == null
            ? []
            : List<dynamic>.from(otherUsersFcmTokens!.map((x) => x)),
      };
}

class User {
  String? id;
  String? name;
  String? mobileNumber;
  String? email;
  List<dynamic>? fcmTokens;
  List<dynamic>? followers;
  List<dynamic>? following;

  User({
    this.id,
    this.name,
    this.mobileNumber,
    this.email,
    this.fcmTokens,
    this.followers,
    this.following,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        fcmTokens: json["fcmTokens"] == null
            ? []
            : List<dynamic>.from(json["fcmTokens"]!.map((x) => x)),
        followers: json["followers"] == null
            ? []
            : List<dynamic>.from(json["followers"]!.map((x) => x)),
        following: json["following"] == null
            ? []
            : List<dynamic>.from(json["following"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobileNumber": mobileNumber,
        "email": email,
        "fcmTokens": fcmTokens == null
            ? []
            : List<dynamic>.from(fcmTokens!.map((x) => x)),
        "followers": followers == null
            ? []
            : List<dynamic>.from(followers!.map((x) => x)),
        "following": following == null
            ? []
            : List<dynamic>.from(following!.map((x) => x)),
      };
}
