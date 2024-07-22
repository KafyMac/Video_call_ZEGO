import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:kaff_video_call/models/profile_model/profile_resp.dart';
import 'package:kaff_video_call/models/stream_model/getStreamResp.dart';
import 'package:kaff_video_call/models/streaming_notifier_model/start_notifier_model.dart';
import 'package:kaff_video_call/models/streaming_notifier_model/start_notifier_resp_model.dart';
import 'package:kaff_video_call/network/api_connection.dart';
import 'package:kaff_video_call/utils/shared/widgets/snack_bar.dart';
import 'package:kaff_video_call/views/screens/home_screen/join_room/join_room_page.dart';
import 'package:kaff_video_call/views/screens/home_screen/liveStreamList/liveStreamList.dart';
import 'package:kaff_video_call/views/screens/live_streaming_interface/live_streaming.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isLoading = false;

  GetAllStreamResp? streamResp;
  GetAllStreamResp? streamHistoryResp;
  GetMyProfileResp? profileResp;
  StartLiveStreamingNotifierResp? startStreamingNotResp;

  TextEditingController _callerId = TextEditingController();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    await getAllStreams();
    await getAllHistoryStreams();
    await getMyProfile();
  }

  Future<void> getAllStreams() async {
    try {
      setState(() {
        isLoading = true;
      });
      streamResp = await ApiService().getAllStreams();

      if (streamResp!.status == "Success") {
      } else {
        setState(() {
          isLoading = false;
        });
        CustomSnackBar.showSnackBar(
            context: context,
            message: streamResp!.message.toString(),
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      CustomSnackBar.showSnackBar(
          context: context,
          message: streamResp!.message ?? "Failed to get all streams",
          color: Colors.red,
          icons: Icons.unpublished_outlined);
    }
  }

  Future<void> getAllHistoryStreams() async {
    try {
      streamHistoryResp = await ApiService().getMyStreamHistory();

      if (streamHistoryResp!.status == "Success") {
      } else {
        setState(() {
          isLoading = false;
        });
        CustomSnackBar.showSnackBar(
            context: context,
            message: streamHistoryResp!.message.toString(),
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      CustomSnackBar.showSnackBar(
          context: context,
          message: streamHistoryResp!.message ?? "Failed to get all streams",
          color: Colors.red,
          icons: Icons.unpublished_outlined);
    }
  }

  Future<void> getMyProfile() async {
    try {
      profileResp = await ApiService().getMyProfile();

      if (profileResp!.status == "Success") {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        CustomSnackBar.showSnackBar(
            context: context,
            message: profileResp!.message.toString(),
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      CustomSnackBar.showSnackBar(
          context: context,
          message: profileResp!.message ?? "Failed to get all streams",
          color: Colors.red,
          icons: Icons.unpublished_outlined);
    }
  }

  Future<void> startStreaming({fcmTokens, liveId, userId, username}) async {
    try {
      var req = StartLiveStreamingNotifier(
          fcmTokens: fcmTokens,
          liveId: liveId,
          userId: userId,
          username: username);
      startStreamingNotResp = await ApiService().startStreamingNotifier(req);

      if (startStreamingNotResp!.status == "Success") {
      } else {
        CustomSnackBar.showSnackBar(
            context: context,
            message: startStreamingNotResp!.message.toString(),
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(
          context: context,
          message:
              startStreamingNotResp!.message ?? "Failed to start streaming!",
          color: Colors.red,
          icons: Icons.unpublished_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: const Text(
          "ZEGO",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: const Color(0xFF530062),
        onRefresh: () async {
          await initialize();
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Live Stream",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: isLoading!
                                    ? null
                                    : () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LiveStreamingHistory(
                                                      streamResp:
                                                          streamHistoryResp),
                                            ));
                                      },
                                child: const Text(
                                  "History",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () async {
                                  _startAsHostDialog(context: context);
                                },
                                child: const Text(
                                  "Click to Start your Live Streaming!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))),
                      ),
                      const SizedBox(height: 10),
                      isLoading!
                          ? Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Color(0xFF530062),
                                )),
                              ),
                            )
                          : Column(
                              children: [
                                if (streamResp?.data?.streams?.length == 0)
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Currently, there are no live streams available",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        streamResp?.data?.streams?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final stream =
                                          streamResp!.data!.streams![index];
                                      if (stream.endedAt == null ||
                                          stream.endedAt!.isEmpty) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: streamingNowCard(
                                            username: stream.username,
                                            onTap: () {
                                              _showJoinDialog(
                                                  context: context,
                                                  streams: streamResp!
                                                      .data!.streams![index]);
                                            },
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                              ],
                            ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Connect",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Connect With People",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const JoinRoom(),
                                    ));
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF530062),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget streamingNowCard({String? username, void Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: AdvancedAvatar(
                name: username ?? "",
                style: const TextStyle(color: Colors.white),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                statusAlignment: Alignment.topRight,
                size: 60,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username ?? "--",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                const Text(
                  "Streaming Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(16)),
            width: 100,
            height: 40,
            child: const Center(
              child: Text(
                "Join now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _startAsHostDialog({BuildContext? context, Stream? streams}) {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Live Stream'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showRoomIdDialog(context, isHost: true);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Start as Host'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showJoinDialog({BuildContext? context, Stream? streams}) {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Join Live Stream'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (streams!.liveId!.isNotEmpty) {
                    Navigator.pop(context);
                    if (ZegoUIKitPrebuiltLiveStreamingController()
                        .minimize
                        .isMinimizing) {
                      return;
                    }
                    jumpToLivePage(
                      context,
                      liveID: streams.liveId!,
                      username: profileResp!.data!.user!.name!,
                      isHost: false,
                      roomId: streams.id,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a valid Room ID')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Join as Viewer'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRoomIdDialog(BuildContext context,
      {required bool isHost, Stream? streams}) {
    TextEditingController roomIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Room ID'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: roomIdController,
                decoration: InputDecoration(labelText: 'Room ID'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: streams != null
                    ? () {
                        print("yes 123456789");
                        if (streams.liveId!.isNotEmpty) {
                          Navigator.pop(context);
                          if (ZegoUIKitPrebuiltLiveStreamingController()
                              .minimize
                              .isMinimizing) {
                            return;
                          }
                          startStreaming(
                              fcmTokens: profileResp!.data!.otherUsersFcmTokens,
                              liveId: streams.liveId,
                              userId: profileResp!.data!.user!.id,
                              username: profileResp!.data!.user!.name);
                          jumpToLivePage(context,
                              liveID: streams.liveId!,
                              username: profileResp!.data!.user!.name!,
                              isHost: isHost,
                              roomId: streams.id);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Please enter a valid Room ID')),
                          );
                        }
                      }
                    : () async {
                        print("12345");
                        print("starting a new stream...");

                        String roomId = roomIdController.text.trim();
                        if (roomId.isNotEmpty) {
                          Navigator.pop(context);
                          if (ZegoUIKitPrebuiltLiveStreamingController()
                              .minimize
                              .isMinimizing) {
                            return;
                          }
                          startStreaming(
                              fcmTokens: profileResp!.data!.otherUsersFcmTokens,
                              liveId: roomId,
                              userId: profileResp!.data!.user!.id,
                              username: profileResp!.data!.user!.name);
                          jumpToLivePage(
                            context,
                            liveID: roomId,
                            username: profileResp!.data!.user!.name!,
                            isHost: isHost,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Please enter a valid Room ID')),
                          );
                        }
                      },
                child: Text('Join'),
              ),
            ],
          ),
        );
      },
    );
  }

  void jumpToLivePage(BuildContext context,
      {required String liveID,
      required bool isHost,
      required String username,
      String? roomId}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LiveStreamingPage(
            liveID: liveID,
            isHost: isHost,
            username: username,
            roomId: roomId)));
  }
}
