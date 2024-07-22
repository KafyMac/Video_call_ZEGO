import 'dart:convert';

StartLiveStreamingNotifierResp startLiveStreamingNotifierRespFromJson(
        String str) =>
    StartLiveStreamingNotifierResp.fromJson(json.decode(str));

String startLiveStreamingNotifierRespToJson(
        StartLiveStreamingNotifierResp data) =>
    json.encode(data.toJson());

class StartLiveStreamingNotifierResp {
  String? status;
  String? message;
  Data? data;

  StartLiveStreamingNotifierResp({
    this.status,
    this.message,
    this.data,
  });

  factory StartLiveStreamingNotifierResp.fromJson(Map<String, dynamic> json) =>
      StartLiveStreamingNotifierResp(
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
  String? token;

  Data({
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
