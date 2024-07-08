import 'dart:convert';

FolloweReq followeReqFromJson(String str) =>
    FolloweReq.fromJson(json.decode(str));

String followeReqToJson(FolloweReq data) => json.encode(data.toJson());

class FolloweReq {
  String? userIdToFollow;

  FolloweReq({
    this.userIdToFollow,
  });

  factory FolloweReq.fromJson(Map<String, dynamic> json) => FolloweReq(
        userIdToFollow: json["userIdToFollow"],
      );

  Map<String, dynamic> toJson() => {
        "userIdToFollow": userIdToFollow,
      };
}
