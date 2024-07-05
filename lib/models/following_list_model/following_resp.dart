import 'dart:convert';

FollowingListResp followersListRespFromJson(String str) =>
    FollowingListResp.fromJson(json.decode(str));

String followersListRespToJson(FollowingListResp data) =>
    json.encode(data.toJson());

class FollowingListResp {
  String? status;
  String? message;
  List<Datum>? data;

  FollowingListResp({
    this.status,
    this.message,
    this.data,
  });

  factory FollowingListResp.fromJson(Map<String, dynamic> json) =>
      FollowingListResp(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  String? name;
  String? mobileNumber;
  String? email;

  Datum({
    this.id,
    this.name,
    this.mobileNumber,
    this.email,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
