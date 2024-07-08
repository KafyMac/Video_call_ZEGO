import 'package:flutter/material.dart';
import 'package:kaff_video_call/views/screens/connect_screen/screens/followersScreen.dart';
import 'package:kaff_video_call/views/screens/connect_screen/screens/followingScreen.dart';
import 'package:kaff_video_call/views/screens/connect_screen/screens/peopleScreen.dart';

class ConnectScreen extends StatefulWidget {
  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Connect",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(99, 33, 33, 33),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(width: 1, color: Colors.grey[900]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.grey[800],
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Search Streamer",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: const TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 4.0,
                    color: Color.fromARGB(255, 83, 0, 98),
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 90.0),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      "People",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Followers",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Following",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Flexible(
              child: TabBarView(
                children: [
                  PeopleList(),
                  FollowersList(),
                  FollowingList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
