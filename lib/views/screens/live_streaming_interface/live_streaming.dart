import 'package:flutter/material.dart';
import 'package:kaff_video_call/models/stream_model/end_stream_req.dart';
import 'package:kaff_video_call/models/stream_model/end_stream_resp.dart';
import 'package:kaff_video_call/network/api_connection.dart';
import 'package:kaff_video_call/utils/constant/key.dart';
import 'package:kaff_video_call/utils/shared/widgets/snack_bar.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class LiveStreamingPage extends StatefulWidget {
  const LiveStreamingPage({
    Key? key,
    required this.username,
    required this.liveID,
    this.roomId,
    this.isHost = false,
  }) : super(key: key);
  final String? roomId;
  final String? username;
  final String? liveID;
  final bool? isHost;

  @override
  State<LiveStreamingPage> createState() => _LiveStreamingPageState();
}

class _LiveStreamingPageState extends State<LiveStreamingPage> {
  EndStreamResp? endStreamResp;

  Future<void> endStreaming({roomId}) async {
    try {
      print('roomId ${roomId}');
      var req = EndStreamReq(streamId: roomId);

      endStreamResp = await ApiService().endStreaming(req);

      if (endStreamResp!.status == "Success") {
        Navigator.pop(context);
      } else {
        CustomSnackBar.showSnackBar(
            context: context,
            message: endStreamResp!.message.toString(),
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(
          context: context,
          message: endStreamResp!.message ?? "Failed to end streaming!",
          color: Colors.red,
          icons: Icons.unpublished_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        events: ZegoUIKitPrebuiltLiveStreamingEvents(
          onEnded: (event, defaultAction) {
            widget.roomId != null && widget.roomId!.isNotEmpty
                ? endStreaming(roomId: widget.roomId)
                : {Navigator.pop(context), print('no roomId')};
          },
        ),
        appID: streamingAPPID,
        appSign: streamingAPPSignKey,
        userID: localUserID,
        userName: widget.username!,
        liveID: widget.liveID!,
        config: widget.isHost == true
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host(
                plugins: [ZegoUIKitSignalingPlugin()],
              )
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(
                plugins: [ZegoUIKitSignalingPlugin()],
              ),
      ),
    );
  }
}
