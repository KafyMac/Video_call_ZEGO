import 'package:flutter/material.dart';
import 'package:kaff_video_call/views/screens/auth_screen/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonDialog {
  void logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 35, 35, 35),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        title: const Text(
          "Logout",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            const Text(
              "Confirm",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(255, 255, 255, 1)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final pref = await SharedPreferences.getInstance();
                        await pref.remove('loggedIn');
                        await pref.remove('userToken');
                        await pref.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 83, 0, 98),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
