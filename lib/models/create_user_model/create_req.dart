import 'dart:convert';

CreateUserReq createUserReqFromJson(String str) =>
    CreateUserReq.fromJson(json.decode(str));

String createUserReqToJson(CreateUserReq data) => json.encode(data.toJson());

class CreateUserReq {
  String? name;
  String? mobileNumber;
  String? email;
  String? password;

  CreateUserReq({
    this.name,
    this.mobileNumber,
    this.email,
    this.password,
  });

  factory CreateUserReq.fromJson(Map<String, dynamic> json) => CreateUserReq(
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobileNumber": mobileNumber,
        "email": email,
        "password": password,
      };
}
