import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:kaff_video_call/models/profile_model/profile_resp.dart';
import 'package:kaff_video_call/models/stream_model/getStreamResp.dart';
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
  GetMyProfileResp? profileResp;

  TextEditingController _callerId = TextEditingController();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    await getAllStreams();
  }

  Future<void> getAllStreams() async {
    try {
      setState(() {
        isLoading = true;
      });
      streamResp = await ApiService().getAllStreams();

      if (streamResp!.status == "Success") {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = true;
        });
        CustomSnackBar.showSnackBar(
            context: context,
            message: streamResp!.message.toString(),
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      CustomSnackBar.showSnackBar(
          context: context,
          message: streamResp!.message ?? "Failed to get all streams",
          color: Colors.red,
          icons: Icons.unpublished_outlined);
    }
  }

  Future<void> getMyProfile() async {
    try {
      setState(() {
        isLoading = true;
      });
      profileResp = await ApiService().getMyProfile();

      if (profileResp!.status == "Success") {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = true;
        });
        CustomSnackBar.showSnackBar(
            context: context,
            message: profileResp!.message.toString(),
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      CustomSnackBar.showSnackBar(
          context: context,
          message: profileResp!.message ?? "Failed to get all streams",
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RefreshIndicator(
            backgroundColor: const Color(0xFF530062),
            onRefresh: () async {
              await getAllStreams();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                                    streamResp: streamResp),
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
                              onTap: () {},
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
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: streamResp?.data?.streams?.length ?? 0,
                            itemBuilder: (context, index) {
                              return streamResp
                                              ?.data?.streams?[index].endedAt !=
                                          "" ||
                                      streamResp
                                              ?.data?.streams?[index].endedAt !=
                                          null
                                  ? Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12))),
                                      child: const Center(
                                          child: Text(
                                        "Currently, there are no live streams available",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    )
                                  : streamingNowCard(
                                      username: streamResp
                                          ?.data?.streams?[index].username,
                                      onTap: () {
                                        _showJoinDialog(context);
                                      });
                            },
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
              ],
            ),
          ),
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

  Widget startLiveStreaming() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (ZegoUIKitPrebuiltLiveStreamingController()
                .minimize
                .isMinimizing) {
              return;
            }
            jumpToLivePage(context,
                liveID: "123", username: "kafeel", isHost: true);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Join as Host'),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {
            if (ZegoUIKitPrebuiltLiveStreamingController()
                .minimize
                .isMinimizing) {
              return;
            }
            jumpToLivePage(context,
                liveID: "123", username: "kafeel", isHost: false);
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Join as Viewer'),
        ),
      ],
    );
  }

  void _startLiveStreaming(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Start Live Stream'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _callerId,
                decoration: InputDecoration(labelText: 'Join group call by id'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (ZegoUIKitPrebuiltLiveStreamingController()
                      .minimize
                      .isMinimizing) {
                    return;
                  }
                  jumpToLivePage(context,
                      liveID: _callerId.text.toString(),
                      username: profileResp!.data!.user!.name ?? "---",
                      isHost: true);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Start'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showJoinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Join Live Stream'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (ZegoUIKitPrebuiltLiveStreamingController()
                      .minimize
                      .isMinimizing) {
                    return;
                  }
                  jumpToLivePage(context,
                      liveID: "123", username: "kafeel", isHost: true);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Join as Host'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  if (ZegoUIKitPrebuiltLiveStreamingController()
                      .minimize
                      .isMinimizing) {
                    return;
                  }
                  jumpToLivePage(context,
                      liveID: "123", username: "kafeel", isHost: false);
                },
                style: OutlinedButton.styleFrom(
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

  void jumpToLivePage(BuildContext context,
      {required String liveID,
      required bool isHost,
      required String username}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LiveStreamingPage(
              liveID: liveID,
              isHost: isHost,
              username: username,
            )));
  }
}
