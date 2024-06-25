import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaff_video_call/views/home_screen/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.lato(textStyle: textTheme.bodyMedium),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
