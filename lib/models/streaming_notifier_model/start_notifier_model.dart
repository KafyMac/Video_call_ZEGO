import 'dart:convert';

StartLiveStreamingNotifier startLiveStreamingNotifierFromJson(String str) =>
    StartLiveStreamingNotifier.fromJson(json.decode(str));

String startLiveStreamingNotifierToJson(StartLiveStreamingNotifier data) =>
    json.encode(data.toJson());

class StartLiveStreamingNotifier {
  String? liveId;
  String? userId;
  String? username;
  List<String>? fcmTokens;

  StartLiveStreamingNotifier({
    this.liveId,
    this.userId,
    this.username,
    this.fcmTokens,
  });

  factory StartLiveStreamingNotifier.fromJson(Map<String, dynamic> json) =>
      StartLiveStreamingNotifier(
        liveId: json["liveID"],
        userId: json["userId"],
        username: json["username"],
        fcmTokens: json["fcmTokens"] == null
            ? []
            : List<String>.from(json["fcmTokens"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "liveID": liveId,
        "userId": userId,
        "username": username,
        "fcmTokens": fcmTokens == null
            ? []
            : List<dynamic>.from(fcmTokens!.map((x) => x)),
      };
}
