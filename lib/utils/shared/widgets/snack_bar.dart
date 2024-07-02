import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar(
      {BuildContext? context, String? message, Color? color, IconData? icons}) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: color,
      content: Row(
        children: [
          Icon(icons, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            message ?? '',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }
}
