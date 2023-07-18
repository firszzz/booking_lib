import 'package:flutter/cupertino.dart';

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path = Path();

    // (0.0) 1. Point
    path.lineTo(0, h); // 2. Point
    /*path.quadraticBezierTo(
      w,   // 3. Point
      h / 3, // 3. Point
      w,   // 4. Point
      h / 3, // 4. Point
    );*/
    path.lineTo(w, h / 1.8);
    path.lineTo(w, 0); // 5. Point


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}