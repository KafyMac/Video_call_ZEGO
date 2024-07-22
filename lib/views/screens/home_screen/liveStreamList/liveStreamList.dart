import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:kaff_video_call/models/stream_model/getStreamResp.dart';
import 'package:kaff_video_call/views/screens/connect_screen/profile_details_screen/profile_details.dart';
import 'package:kaff_video_call/views/screens/home_screen/join_room/join_room_page.dart';

class LiveStreamingHistory extends StatefulWidget {
  final GetAllStreamResp? streamResp;
  const LiveStreamingHistory({required this.streamResp, super.key});

  @override
  State<LiveStreamingHistory> createState() => _LiveStreamingHistoryState();
}

class _LiveStreamingHistoryState extends State<LiveStreamingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        title: const Text(
          "Live Streaming History",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: widget.streamResp?.data?.streams?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                final String? endedAtString =
                    widget.streamResp?.data?.streams?[index].endedAt;
                final String? createdAtString =
                    widget.streamResp?.data?.streams?[index].createdAt!;

                String formattedDuration =
                    "Duration not available"; // Default value

                if (endedAtString != null && createdAtString != null) {
                  final DateTime endedAt = DateTime.parse(endedAtString);
                  final DateTime createdAt = DateTime.parse(createdAtString);

                  final Duration duration = endedAt.difference(createdAt);

                  final int hours = duration.inHours;
                  final int minutes = duration.inMinutes.remainder(60);

                  formattedDuration =
                      '${hours.toString().padLeft(2, '0')}h:${minutes.toString().padLeft(2, '0')}m';
                }

                return historyStreamCard(
                  duration: formattedDuration,
                  username: widget.streamResp?.data?.streams?[index].username ??
                      'Unknown',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget historyStreamCard({String? username, String? duration}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/profile.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Text(
                    duration ?? '00h:00m',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(108, 255, 255, 255),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 6.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                "  1.2k",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                        ),
                        child: const Center(
                          child: Text(
                            "Live",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AdvancedAvatar(
                image: const AssetImage("assets/profile.jpeg"),
                name: username ?? "--",
                style: const TextStyle(color: Colors.white),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                statusAlignment: Alignment.topRight,
                size: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username ?? "--",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const Text(
                      "123k Followers",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              PopupMenuButton<String>(
                color: Colors.black,
                elevation: 2,
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ),
                onSelected: (String result) {
                  setState(() {
                    if (result == "Join") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JoinRoom(),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileDetailsScreen(),
                          ));
                    }
                  });
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'Join',
                    child: Text(
                      'Join Room',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Profile',
                    child: Text(
                      'Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
