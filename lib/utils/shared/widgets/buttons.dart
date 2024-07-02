// import 'package:flutter/material.dart';

// Widget button(
//     {required void Function()? onPressed,
//     required String title,
//     required double width,
//     required double height,
//     double? borderRadius,
//     Color? color,
//     Color? fontColor}) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//             color: color,
//             borderRadius:
//                 BorderRadius.all(Radius.circular(borderRadius ?? 8.0))),
//         child: Center(
//             child: Text(
//           title,
//           style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: fontColor ?? Colors.black),
//         )),
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';

Widget button({
  required void Function()? onPressed,
  required String title,
  required double width,
  required double height,
  double? borderRadius,
  Color? color,
  Color? fontColor,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: fontColor ?? Colors.black,
        ),
      ),
    ),
  );
}
