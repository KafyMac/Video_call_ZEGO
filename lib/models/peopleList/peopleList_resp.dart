import 'dart:convert';

PeopleListResp peopleListRespFromJson(String str) =>
    PeopleListResp.fromJson(json.decode(str));

String peopleListRespToJson(PeopleListResp data) => json.encode(data.toJson());

class PeopleListResp {
  String? status;
  String? message;
  Data? data;

  PeopleListResp({
    this.status,
    this.message,
    this.data,
  });

  factory PeopleListResp.fromJson(Map<String, dynamic> json) => PeopleListResp(
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
  List<User>? users;
  int? total;

  Data({
    this.users,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "total": total,
      };
}

class User {
  String? id;
  String? name;
  String? mobileNumber;
  String? email;

  User({
    this.id,
    this.name,
    this.mobileNumber,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
