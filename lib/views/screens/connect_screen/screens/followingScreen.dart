import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:kaff_video_call/models/following_list_model/following_resp.dart';
import 'package:kaff_video_call/models/unfollow_model/unfollow_req.dart';
import 'package:kaff_video_call/models/unfollow_model/unfollow_resp.dart';
import 'package:kaff_video_call/network/api_connection.dart';
import 'package:kaff_video_call/utils/shared/widgets/snack_bar.dart';
import 'package:kaff_video_call/views/screens/connect_screen/profile_details_screen/profile_details.dart';

class FollowingList extends StatefulWidget {
  const FollowingList({super.key});

  @override
  State<FollowingList> createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  List<Datum>? followingList = [];
  Map<String, bool> _isLoadingMap = {};

  @override
  void initState() {
    fetchFollowersList();
    super.initState();
  }

  Future<void> fetchFollowersList() async {
    try {
      FollowingListResp? resp = await ApiService().followingList();
      if (resp.status == "Success") {
        setState(() {
          followingList = resp.data;
          _isLoadingMap = {for (var user in resp.data!) user.id!: false};
        });
      } else {
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Failed to fetch account",
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    } catch (error) {
      CustomSnackBar.showSnackBar(
          context: context,
          message: "Error while fetching account",
          color: Colors.red,
          icons: Icons.unpublished_outlined);
    }
  }

  Future<void> unFollowUser(String? id) async {
    setState(() {
      _isLoadingMap[id!] = true;
    });

    var req = UnfolloweReq(userIdToUnfollow: id);
    try {
      UnfolloweResp? resp = await ApiService().unFollowUser(req);
      if (resp.status == "Success") {
        fetchFollowersList();
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Un-Followed",
            color: Colors.green,
            icons: Icons.unpublished_outlined);
      } else {
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Failed to un-follow",
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    } catch (error) {
      CustomSnackBar.showSnackBar(
          context: context,
          message: "Error while Un-Following",
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
        child: followingList!.isEmpty
            ? const Center(
                child: Text(
                  "You are not following any one",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: followingList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return followingContainer(
                          context,
                          index: index,
                          name: followingList?[index].name ?? "--",
                          isLoading:
                              _isLoadingMap[followingList?[index].id] ?? false,
                          onTap: () {
                            unFollowUser(followingList?[index].id);
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

  Widget followingContainer(
    BuildContext context, {
    required int index,
    String? name,
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
                      name ?? "--",
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
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              width: 100,
              height: 40,
              child: Center(
                child: !isLoading
                    ? const Text(
                        "Unfollow",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      )
                    : const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 1,
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
