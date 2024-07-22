import 'dart:convert';

EndStreamResp endStreamRespFromJson(String str) =>
    EndStreamResp.fromJson(json.decode(str));

String endStreamRespToJson(EndStreamResp data) => json.encode(data.toJson());

class EndStreamResp {
  String? status;
  String? message;
  Data? data;

  EndStreamResp({
    this.status,
    this.message,
    this.data,
  });

  factory EndStreamResp.fromJson(Map<String, dynamic> json) => EndStreamResp(
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
  Stream? stream;

  Data({
    this.stream,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stream: json["stream"] == null ? null : Stream.fromJson(json["stream"]),
      );

  Map<String, dynamic> toJson() => {
        "stream": stream?.toJson(),
      };
}

class Stream {
  String? id;
  String? liveId;
  String? userId;
  String? username;
  List<String>? fcmTokens;
  DateTime? endedAt;
  DateTime? createdAt;

  Stream({
    this.id,
    this.liveId,
    this.userId,
    this.username,
    this.fcmTokens,
    this.endedAt,
    this.createdAt,
  });

  factory Stream.fromJson(Map<String, dynamic> json) => Stream(
        id: json["_id"],
        liveId: json["liveID"],
        userId: json["userId"],
        username: json["username"],
        fcmTokens: json["fcmTokens"] == null
            ? []
            : List<String>.from(json["fcmTokens"]!.map((x) => x)),
        endedAt:
            json["endedAt"] == null ? null : DateTime.parse(json["endedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "liveID": liveId,
        "userId": userId,
        "username": username,
        "fcmTokens": fcmTokens == null
            ? []
            : List<dynamic>.from(fcmTokens!.map((x) => x)),
        "endedAt": endedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
