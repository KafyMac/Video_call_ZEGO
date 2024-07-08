import 'dart:convert';

FolloweResp followeRespFromJson(String str) =>
    FolloweResp.fromJson(json.decode(str));

String followeRespToJson(FolloweResp data) => json.encode(data.toJson());

class FolloweResp {
  String? status;
  String? message;
  Data? data;

  FolloweResp({
    this.status,
    this.message,
    this.data,
  });

  factory FolloweResp.fromJson(Map<String, dynamic> json) => FolloweResp(
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
  CurrentUser? userToFollow;

  Data({
    this.currentUser,
    this.userToFollow,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentUser: json["currentUser"] == null
            ? null
            : CurrentUser.fromJson(json["currentUser"]),
        userToFollow: json["userToFollow"] == null
            ? null
            : CurrentUser.fromJson(json["userToFollow"]),
      );

  Map<String, dynamic> toJson() => {
        "currentUser": currentUser?.toJson(),
        "userToFollow": userToFollow?.toJson(),
      };
}

class CurrentUser {
  String? id;
  String? name;
  String? mobileNumber;
  String? email;
  String? password;
  List<Follow>? followers;
  List<Follow>? following;

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
            : List<Follow>.from(
                json["followers"]!.map((x) => Follow.fromJson(x))),
        following: json["following"] == null
            ? []
            : List<Follow>.from(
                json["following"]!.map((x) => Follow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobileNumber": mobileNumber,
        "email": email,
        "password": password,
        "followers": followers == null
            ? []
            : List<dynamic>.from(followers!.map((x) => x.toJson())),
        "following": following == null
            ? []
            : List<dynamic>.from(following!.map((x) => x.toJson())),
      };
}

class Follow {
  String? id;
  String? name;
  String? mobileNumber;
  String? email;

  Follow({
    this.id,
    this.name,
    this.mobileNumber,
    this.email,
  });

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
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
