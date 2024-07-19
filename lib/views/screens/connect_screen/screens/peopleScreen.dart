import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:kaff_video_call/models/Follow_model/follow_req.dart';
import 'package:kaff_video_call/models/Follow_model/follow_resp.dart';
import 'package:kaff_video_call/models/peopleList/peopleList_resp.dart';
import 'package:kaff_video_call/network/api_connection.dart';
import 'package:kaff_video_call/utils/shared/widgets/snack_bar.dart';
import 'package:kaff_video_call/views/screens/connect_screen/profile_details_screen/profile_details.dart';

class PeopleList extends StatefulWidget {
  const PeopleList({super.key});

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  PeopleListResp? peopleList;
  Map<String, bool> _isLoadingMap = {};

  @override
  void initState() {
    fetchFollowersList();
    super.initState();
  }

  Future<void> fetchFollowersList() async {
    try {
      peopleList = await ApiService().peopleList();
      if (peopleList?.status == "Failed") {
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Failed to fetch account",
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      } else {
        setState(() {
          _isLoadingMap = {
            for (var user in peopleList!.data!.users!) user.id!: false
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
        child: peopleList != null && peopleList!.data!.users!.isEmpty
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
                      itemCount: peopleList?.data?.users?.length ?? 0,
                      itemBuilder: (context, index) {
                        final user = peopleList?.data?.users?[index];
                        return peopleListCard(
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

  Widget peopleListCard(
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
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(16),
              ),
              width: 100,
              height: 40,
              child: Center(
                child: !isLoading
                    ? const Text(
                        "Follow",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      )
                    : const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
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
