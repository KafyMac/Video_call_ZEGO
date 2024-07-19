import 'dart:convert';

CreateUserResp createUserRespFromJson(String str) =>
    CreateUserResp.fromJson(json.decode(str));

String createUserRespToJson(CreateUserResp data) => json.encode(data.toJson());

class CreateUserResp {
  String? status;
  String? message;
  Data? data;

  CreateUserResp({
    this.status,
    this.message,
    this.data,
  });

  factory CreateUserResp.fromJson(Map<String, dynamic> json) => CreateUserResp(
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
  String? name;
  String? email;
  String? mobileNumber;
  String? fcmToken;

  User({
    this.name,
    this.email,
    this.mobileNumber,
    this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobileNumber": mobileNumber,
        "fcmToken": fcmToken,
      };
}
