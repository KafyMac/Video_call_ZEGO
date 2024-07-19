import 'dart:convert';

GetAllStreamResp getAllStreamRespFromJson(String str) =>
    GetAllStreamResp.fromJson(json.decode(str));

String getAllStreamRespToJson(GetAllStreamResp data) =>
    json.encode(data.toJson());

class GetAllStreamResp {
  String? status;
  String? message;
  Data? data;

  GetAllStreamResp({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllStreamResp.fromJson(Map<String, dynamic> json) =>
      GetAllStreamResp(
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
  List<Stream>? streams;

  Data({
    this.streams,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        streams: json["streams"] == null
            ? []
            : List<Stream>.from(
                json["streams"]!.map((x) => Stream.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "streams": streams == null
            ? []
            : List<dynamic>.from(streams!.map((x) => x.toJson())),
      };
}

class Stream {
  String? id;
  String? userId;
  String? username;
  String? fcmToken;
  String? endedAt;
  String? createdAt;

  Stream({
    this.id,
    this.userId,
    this.username,
    this.fcmToken,
    this.endedAt,
    this.createdAt,
  });

  factory Stream.fromJson(Map<String, dynamic> json) => Stream(
        id: json["_id"],
        userId: json["userId"],
        username: json["username"],
        fcmToken: json["fcmToken"],
        endedAt: json["endedAt"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "username": username,
        "fcmToken": fcmToken,
        "endedAt": endedAt,
        "createdAt": createdAt,
      };
}
