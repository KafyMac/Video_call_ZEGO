import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaff_video_call/views/screens/connect_screen/connect_page.dart';
import 'package:kaff_video_call/views/screens/home_screen/home_page.dart';
import 'package:kaff_video_call/views/screens/more_screen/more_page.dart';

class HomeScreens extends StatefulWidget {
  String? endDateTime;
  HomeScreens({super.key, this.endDateTime});
  static const route = "home";

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  Widget? currentPages;
  int currentPage = 0;

  ScreenOne() {
    setState(() {
      currentPages = HomeScreen();
    });
  }

  ScreenTwo() {
    setState(() {
      currentPages = ConnectScreen();
    });
  }

  ScreenThree() {
    setState(() {
      currentPages = MoreScreen();
    });
  }

  @override
  void initState() {
    super.initState();
    int initialPage = Get.arguments ?? 0;
    currentPage = initialPage;
    switch (initialPage) {
      case 0:
        ScreenOne();
        break;
      case 1:
        ScreenTwo();
        break;
      case 2:
        ScreenThree();
        break;
      default:
        ScreenOne();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPages,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 60,
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 2,
                              color: currentPage == 0
                                  ? Color.fromARGB(255, 83, 0, 98)
                                  : Colors.white)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          currentPage == 0
                              ? Icon(
                                  Icons.home_outlined,
                                  color: Color.fromARGB(255, 83, 0, 98),
                                )
                              : Icon(
                                  Icons.home_outlined,
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  color: currentPage == 0
                                      ? Color.fromARGB(255, 83, 0, 98)
                                      : const Color.fromRGBO(90, 90, 90, 1),
                                  fontSize: (13),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    ScreenOne();
                    setState(() {
                      currentPage = 0;
                    });
                  },
                ),
              ),
              Container(
                height: 60,
                child: InkWell(
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                          width: 2,
                          color: currentPage == 1
                              ? Color.fromARGB(255, 83, 0, 98)
                              : Colors.white,
                        )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            currentPage == 1
                                ? Icon(
                                    Icons.connect_without_contact_rounded,
                                    color: Color.fromARGB(255, 83, 0, 98),
                                  )
                                : Icon(
                                    Icons.connect_without_contact_rounded,
                                    color: Color.fromRGBO(90, 90, 90, 1),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                "Connect",
                                style: TextStyle(
                                    color: currentPage == 1
                                        ? Color.fromARGB(255, 83, 0, 98)
                                        : const Color.fromRGBO(90, 90, 90, 1),
                                    fontSize: (13),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      )),
                  onTap: () {
                    ScreenTwo();
                    setState(() {
                      currentPage = 1;
                    });
                  },
                ),
              ),
              Container(
                height: 60,
                child: InkWell(
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 2,
                                color: currentPage == 2
                                    ? Color.fromARGB(255, 83, 0, 98)
                                    : Colors.white)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            currentPage == 2
                                ? Icon(
                                    Icons.account_circle_outlined,
                                    color: Color.fromARGB(255, 83, 0, 98),
                                  )
                                : Icon(
                                    Icons.account_circle_outlined,
                                    color: Color.fromRGBO(90, 90, 90, 1),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                "More",
                                style: TextStyle(
                                    color: currentPage == 2
                                        ? Color.fromARGB(255, 83, 0, 98)
                                        : const Color.fromRGBO(90, 90, 90, 1),
                                    fontSize: (13),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      )),
                  onTap: () {
                    ScreenThree();
                    setState(() {
                      currentPage = 2;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
