import 'package:flutter/material.dart';
import 'package:kaff_video_call/utils/shared/widgets/splashScreen.dart';
import 'package:kaff_video_call/views/screens/auth_screen/login_page.dart';
import 'package:kaff_video_call/views/screens/bottomNavbar/bottomnavbar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> _checkAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getToken = prefs.getString('userToken');
    return getToken;
  }

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return ProviderScope(
      child: FutureBuilder<String?>(
        future: _checkAuthToken(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              title: '3Ev',
              theme: ThemeData(
                useMaterial3: false,
                fontFamily: 'Poppins',
                primaryColor: const Color.fromARGB(255, 16, 16, 16),
              ),
              routes: {
                '/home': (context) => SplashScreen(),
              },
              home: HomeScreens(),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              title: '3Ev',
              theme: ThemeData(
                useMaterial3: false,
                fontFamily: 'Poppins',
                primaryColor: const Color.fromARGB(255, 16, 16, 16),
              ),
              routes: {
                '/home': (context) => const LoginPage(),
              },
              home: SplashScreen(),
            );
          }
        },
      ),
    );
  }
}
