import 'dart:convert';

LoginResp loginRespFromJson(String str) => LoginResp.fromJson(json.decode(str));

String loginRespToJson(LoginResp data) => json.encode(data.toJson());

class LoginResp {
  String? status;
  String? message;
  LoginData? data;

  LoginResp({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResp.fromJson(Map<String, dynamic> json) => LoginResp(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class LoginData {
  String? token;
  User? user;

  LoginData({
    this.token,
    this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
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
