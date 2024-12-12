import 'package:flutter/material.dart';

class Fondo extends StatelessWidget {
  final Widget child;
  final boxDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 1.0],
      colors: [
        Color(0xffC8D0E0),
        Color.fromARGB(255, 255, 211, 176),
      ],
    ),
  );

  Fondo({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: boxDecoration,
        child: child,
      ),
    );
  }
}
