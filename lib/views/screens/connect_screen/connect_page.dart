import 'package:flutter/material.dart';
import 'package:kaff_video_call/views/screens/connect_screen/screens/followScreen.dart';
import 'package:kaff_video_call/views/screens/connect_screen/screens/followingScreen.dart';
import 'package:kaff_video_call/views/screens/connect_screen/screens/peopleScreen.dart';

class ConnectScreen extends StatefulWidget {
  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  int _selectedIndex = 0;
  bool isActive = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      isActive = index == 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      body: Column(
        children: <Widget>[
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
                    )
                  ],
                ),
              ),
            ),
          ),
          Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment: _selectedIndex == 0
                    ? Alignment.centerLeft
                    : _selectedIndex == 1
                        ? Alignment.center
                        : Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 83, 0, 98),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _onItemTapped(0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: 50,
                      child: const Center(
                        child: Text(
                          "People",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(1),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Followers",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(2),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Following",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                PeopleList(),
                FollowList(),
                FollowingList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
