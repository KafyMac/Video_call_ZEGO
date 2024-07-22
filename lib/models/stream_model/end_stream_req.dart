import 'dart:convert';

EndStreamReq endStreamReqFromJson(String str) =>
    EndStreamReq.fromJson(json.decode(str));

String endStreamReqToJson(EndStreamReq data) => json.encode(data.toJson());

class EndStreamReq {
  String? streamId;

  EndStreamReq({
    this.streamId,
  });

  factory EndStreamReq.fromJson(Map<String, dynamic> json) => EndStreamReq(
        streamId: json["streamId"],
      );

  Map<String, dynamic> toJson() => {
        "streamId": streamId,
      };
}
