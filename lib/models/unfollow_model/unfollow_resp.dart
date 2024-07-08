import 'dart:convert';

UnfolloweResp unfolloweRespFromJson(String str) =>
    UnfolloweResp.fromJson(json.decode(str));

String unfolloweRespToJson(UnfolloweResp data) => json.encode(data.toJson());

class UnfolloweResp {
  String? status;
  String? message;
  Data? data;

  UnfolloweResp({
    this.status,
    this.message,
    this.data,
  });

  factory UnfolloweResp.fromJson(Map<String, dynamic> json) => UnfolloweResp(
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
  CurrentUser? currentUser;
  CurrentUser? userToUnfollow;

  Data({
    this.currentUser,
    this.userToUnfollow,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentUser: json["currentUser"] == null
            ? null
            : CurrentUser.fromJson(json["currentUser"]),
        userToUnfollow: json["userToUnfollow"] == null
            ? null
            : CurrentUser.fromJson(json["userToUnfollow"]),
      );

  Map<String, dynamic> toJson() => {
        "currentUser": currentUser?.toJson(),
        "userToUnfollow": userToUnfollow?.toJson(),
      };
}

class CurrentUser {
  String? id;
  String? name;
  String? mobileNumber;
  String? email;
  String? password;
  List<dynamic>? followers;
  List<Following>? following;

  CurrentUser({
    this.id,
    this.name,
    this.mobileNumber,
    this.email,
    this.password,
    this.followers,
    this.following,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
        id: json["_id"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        password: json["password"],
        followers: json["followers"] == null
            ? []
            : List<dynamic>.from(json["followers"]!.map((x) => x)),
        following: json["following"] == null
            ? []
            : List<Following>.from(
                json["following"]!.map((x) => Following.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobileNumber": mobileNumber,
        "email": email,
        "password": password,
        "followers": followers == null
            ? []
            : List<dynamic>.from(followers!.map((x) => x)),
        "following": following == null
            ? []
            : List<dynamic>.from(following!.map((x) => x.toJson())),
      };
}

class Following {
  String? id;
  String? name;
  String? mobileNumber;
  String? email;

  Following({
    this.id,
    this.name,
    this.mobileNumber,
    this.email,
  });

  factory Following.fromJson(Map<String, dynamic> json) => Following(
        id: json["_id"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobileNumber": mobileNumber,
        "email": email,
      };
}
