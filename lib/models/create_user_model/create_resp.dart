import 'dart:convert';

CreateUserResp createUserRespFromJson(String str) =>
    CreateUserResp.fromJson(json.decode(str));

String createUserRespToJson(CreateUserResp data) => json.encode(data.toJson());

class CreateUserResp {
  String? success;
  String? message;
  Data? data;

  CreateUserResp({
    this.success,
    this.message,
    this.data,
  });

  factory CreateUserResp.fromJson(Map<String, dynamic> json) => CreateUserResp(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
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

  User({
    this.name,
    this.email,
    this.mobileNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobileNumber": mobileNumber,
      };
}
