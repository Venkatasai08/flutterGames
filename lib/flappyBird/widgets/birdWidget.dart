import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  const MyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/Flappy-bird.png",
      height: 70,
      width: 70,
    );
  }
}
