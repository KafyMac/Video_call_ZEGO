import 'dart:convert';

UnfolloweReq unfolloweRespFromJson(String str) =>
    UnfolloweReq.fromJson(json.decode(str));

String unfolloweRespToJson(UnfolloweReq data) => json.encode(data.toJson());

class UnfolloweReq {
  String? userIdToUnfollow;

  UnfolloweReq({
    this.userIdToUnfollow,
  });

  factory UnfolloweReq.fromJson(Map<String, dynamic> json) => UnfolloweReq(
        userIdToUnfollow: json["userIdToUnfollow"],
      );

  Map<String, dynamic> toJson() => {
        "userIdToUnfollow": userIdToUnfollow,
      };
}
