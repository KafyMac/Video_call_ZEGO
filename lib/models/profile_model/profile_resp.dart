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

  Data({
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  String? name;
  String? mobileNumber;
  String? email;
  String? fcmToken;
  List<dynamic>? followers;
  List<dynamic>? following;

  User({
    this.id,
    this.name,
    this.mobileNumber,
    this.email,
    this.fcmToken,
    this.followers,
    this.following,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        fcmToken: json["fcmToken"],
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
        "fcmToken": fcmToken,
        "followers": followers == null
            ? []
            : List<dynamic>.from(followers!.map((x) => x)),
        "following": following == null
            ? []
            : List<dynamic>.from(following!.map((x) => x)),
      };
}
