import 'package:flutter/material.dart';
import 'package:kaff_video_call/constant/key.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID, required this.uName})
      : super(key: key);
  final String callID;
  final String uName;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          APP_ID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: APP_SIGN_KEY,
      userID: uName + '123',
      userName: uName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      // ..onOnlySelfInRoom = (_) => Navigator.of(context).pop(),
    );
  }
}
