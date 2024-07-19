import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:kaff_video_call/models/Follow_model/follow_req.dart';
import 'package:kaff_video_call/models/Follow_model/follow_resp.dart';
import 'package:kaff_video_call/models/followers_model/followers_resp.dart';
import 'package:kaff_video_call/network/api_connection.dart';
import 'package:kaff_video_call/utils/shared/widgets/snack_bar.dart';
import 'package:kaff_video_call/views/screens/connect_screen/profile_details_screen/profile_details.dart';

class FollowersList extends StatefulWidget {
  const FollowersList({super.key});

  @override
  State<FollowersList> createState() => _FollowersListState();
}

class _FollowersListState extends State<FollowersList> {
  late bool follow = true;
  FollowersListResp? followersList;
  Map<String, bool> _isLoadingMap = {};

  @override
  void initState() {
    fetchFollowersList();
    super.initState();
  }

  Future<void> fetchFollowersList() async {
    try {
      followersList = await ApiService().followersList();
      if (followersList?.status == "Failed") {
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Failed to fetch account",
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      } else {
        setState(() {
          _isLoadingMap = {
            for (var user in followersList!.data!) user.id!: false
          };
        });
      }
    } catch (error) {
      CustomSnackBar.showSnackBar(
          context: context,
          message: "Error while fetching account",
          color: Colors.red,
          icons: Icons.unpublished_outlined);
    }
  }

  Future<void> followUser(String? id) async {
    setState(() {
      _isLoadingMap[id!] = true;
    });

    var req = FolloweReq(userIdToFollow: id);
    try {
      FolloweResp? resp = await ApiService().followUser(req);
      if (resp.status == "Success") {
        fetchFollowersList();
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Following",
            color: Colors.green,
            icons: Icons.unpublished_outlined);
      } else {
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Failed to follow",
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    } catch (error) {
      CustomSnackBar.showSnackBar(
          context: context,
          message: "Error while Following",
          color: Colors.red,
          icons: Icons.unpublished_outlined);
    } finally {
      setState(() {
        _isLoadingMap[id!] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: followersList != null && followersList!.data!.isEmpty
            ? const Center(
                child: Text(
                  "You are not followed by any one",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: followersList?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final user = followersList?.data?[index];
                        return followersContainer(
                          context,
                          index: index,
                          name: user?.name ?? "--",
                          isLoading: _isLoadingMap[user?.id] ?? false,
                          onTap: () {
                            followUser(user?.id);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Padding followersContainer(
    BuildContext context, {
    required int index,
    required String name,
    required bool isLoading,
    required void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileDetailsScreen(),
                ),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: AdvancedAvatar(
                    image: const AssetImage("assets/profile.jpeg"),
                    name: name,
                    style: const TextStyle(color: Colors.white),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    statusAlignment: Alignment.topRight,
                    size: 60,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Streaming $index",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: !isLoading
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(16)),
                    width: 100,
                    height: 40,
                    child: const Center(
                      child: Text(
                        "Follow",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    width: 100,
                    height: 40,
                    child: const Center(
                      child: Text(
                        "Following",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
