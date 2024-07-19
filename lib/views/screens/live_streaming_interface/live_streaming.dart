import 'package:flutter/material.dart';
import 'package:kaff_video_call/utils/constant/key.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LiveStreamingPage extends StatelessWidget {
  const LiveStreamingPage({
    Key? key,
    required this.username,
    required this.liveID,
    this.isHost = false,
  }) : super(key: key);
  final String? username;
  final String? liveID;
  final bool? isHost;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        events: ZegoUIKitPrebuiltLiveStreamingEvents(
          room: ZegoLiveStreamingRoomEvents(
            onStateChanged: (p0) {},
          ),
          user: ZegoLiveStreamingUserEvents(
            onEnter: (p0) {},
          ),
          coHost: ZegoLiveStreamingCoHostEvents(
              audience: ZegoLiveStreamingCoHostAudienceEvents()),
          onEnded: (event, defaultAction) {},
        ),
        appID: streamingAPPID,
        appSign: streamingAPPSignKey,
        userID: localUserID,
        userName: username!,
        liveID: liveID!,
        config: isHost == true
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}
