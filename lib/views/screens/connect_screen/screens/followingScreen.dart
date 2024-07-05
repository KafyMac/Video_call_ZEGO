import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:kaff_video_call/models/following_list_model/following_resp.dart';
import 'package:kaff_video_call/network/api_connection.dart';
import 'package:kaff_video_call/utils/shared/widgets/snack_bar.dart';
import 'package:kaff_video_call/views/screens/connect_screen/profile_details_screen/profile_details.dart';

class FollowingList extends StatefulWidget {
  const FollowingList({super.key});

  @override
  State<FollowingList> createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  late bool follow = true;
  List<Datum>? followingList = [];

  @override
  void initState() {
    fetchFollowersList();
    super.initState();
  }

  Future<void> fetchFollowersList() async {
    try {
      FollowingListResp? resp = await ApiService().followingList();
      print("response follow: ${resp.toJson()}");
      if (resp.status == "Success") {
        setState(() {
          followingList = resp.data;
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
                                      builder: (context) =>
                                          const ProfileDetailsScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: AdvancedAvatar(
                                        image: const AssetImage(
                                            "assets/profile.jpeg"),
                                        name: followingList?[index].name,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50.0)),
                                        ),
                                        statusAlignment: Alignment.topRight,
                                        size: 60,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          followingList![index].name.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "Streaming ${index.toString()}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      follow = false;
                                    });
                                  },
                                  child: follow
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
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
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
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
                                        )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
