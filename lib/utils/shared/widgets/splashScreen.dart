import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 83, 0, 98),
                  Color.fromARGB(255, 0, 0, 0)
                ],
              ),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              opacity: opacityLevel,
              duration: const Duration(milliseconds: 1000),
              onEnd: _navigateToNextScreen,
              child: SizedBox(
                height: screenHeight * 0.15,
                child: Image.asset("assets/logo.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
