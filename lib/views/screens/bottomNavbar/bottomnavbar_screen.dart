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

  screenOne() {
    setState(() {
      currentPages = const HomeScreen();
    });
  }

  screenTwo() {
    setState(() {
      currentPages = ConnectScreen();
    });
  }

  screenThree() {
    setState(() {
      currentPages = const MoreScreen();
    });
  }

  @override
  void initState() {
    super.initState();
    int initialPage = Get.arguments ?? 0;
    currentPage = initialPage;
    switch (initialPage) {
      case 0:
        screenOne();
        break;
      case 1:
        screenTwo();
        break;
      case 2:
        screenThree();
        break;
      default:
        screenOne();
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
              SizedBox(
                height: 60,
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 2,
                              color: currentPage == 0
                                  ? const Color.fromARGB(255, 83, 0, 98)
                                  : Colors.white)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          currentPage == 0
                              ? const Icon(
                                  Icons.home_outlined,
                                  color: Color.fromARGB(255, 83, 0, 98),
                                )
                              : const Icon(
                                  Icons.home_outlined,
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  color: currentPage == 0
                                      ? const Color.fromARGB(255, 83, 0, 98)
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
                    screenOne();
                    setState(() {
                      currentPage = 0;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 60,
                child: InkWell(
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                          width: 2,
                          color: currentPage == 1
                              ? const Color.fromARGB(255, 83, 0, 98)
                              : Colors.white,
                        )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            currentPage == 1
                                ? const Icon(
                                    Icons.connect_without_contact_rounded,
                                    color: Color.fromARGB(255, 83, 0, 98),
                                  )
                                : const Icon(
                                    Icons.connect_without_contact_rounded,
                                    color: Color.fromRGBO(90, 90, 90, 1),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                "Connect",
                                style: TextStyle(
                                    color: currentPage == 1
                                        ? const Color.fromARGB(255, 83, 0, 98)
                                        : const Color.fromRGBO(90, 90, 90, 1),
                                    fontSize: (13),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      )),
                  onTap: () {
                    screenTwo();
                    setState(() {
                      currentPage = 1;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 60,
                child: InkWell(
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 2,
                                color: currentPage == 2
                                    ? const Color.fromARGB(255, 83, 0, 98)
                                    : Colors.white)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            currentPage == 2
                                ? const Icon(
                                    Icons.account_circle_outlined,
                                    color: Color.fromARGB(255, 83, 0, 98),
                                  )
                                : const Icon(
                                    Icons.account_circle_outlined,
                                    color: Color.fromRGBO(90, 90, 90, 1),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                "More",
                                style: TextStyle(
                                    color: currentPage == 2
                                        ? const Color.fromARGB(255, 83, 0, 98)
                                        : const Color.fromRGBO(90, 90, 90, 1),
                                    fontSize: (13),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      )),
                  onTap: () {
                    screenThree();
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
