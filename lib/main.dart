import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kaff_video_call/utils/message/message.dart';
import 'package:kaff_video_call/utils/shared/widgets/splashScreen.dart';
import 'package:kaff_video_call/views/screens/auth_screen/login_page.dart';
import 'package:kaff_video_call/views/screens/bottomNavbar/bottomnavbar_screen.dart';
import 'package:kaff_video_call/views/screens/message_screen/message_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final navigatorKey = GlobalKey<NavigatorState>();
final PushNotifications _notificationService = PushNotifications();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyBxSoCtSXd7NPaQXES-EKYrMDwOen5WsIM',
              appId: "1:97393137824:android:2517076c45c4d7f73411c5",
              messagingSenderId: "97393137824",
              projectId: 'zego-e33a6'))
      : await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  PushNotifications.init();
  PushNotifications.localNotiInit();

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    print("message ${message}");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // ZegoUIKit().initLog().then((value) {
  runApp(const MyApp());
  // });
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
                '/message': (context) => MessagePage()
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
                '/message': (context) => MessagePage()
              },
              home: SplashScreen(),
            );
          }
        },
      ),
    );
  }
}
