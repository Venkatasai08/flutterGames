import 'package:flutter/material.dart';
import 'package:fluttergames/flappyBird/getx/flappyBirdController.dart';
import 'package:get/get.dart';

class ScoresWidget extends GetView<FlappyBirdController> {
  const ScoresWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Score",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "0",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Best",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "0",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        )
      ],
    );
  }
}
