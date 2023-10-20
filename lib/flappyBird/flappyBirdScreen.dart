import 'package:flutter/material.dart';
import 'package:fluttergames/flappyBird/getx/flappyBirdController.dart';
import 'package:fluttergames/flappyBird/widgets/ListOfBarriers.dart';
import 'package:fluttergames/flappyBird/widgets/scoresWidget.dart';
import 'package:get/get.dart';

import 'widgets/birdWidget.dart';

class FlappyBirdScreen extends StatelessWidget {
  const FlappyBirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FlappyBirdController controller = Get.put(FlappyBirdController());
    return GestureDetector(
      onTap: () {
        if (controller.gameHasStarted.value) {
          controller.jump();
        } else {
          controller.startGame();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Obx(() {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        alignment: Alignment(0.0, controller.birdYaxis.value),
                        color: Colors.blue,
                        child: const MyBird(),
                      );
                    }),
                    Container(
                      alignment: const Alignment(0, -0.3),
                      child: Obx(() {
                        return controller.gameHasStarted.value
                            ? const SizedBox()
                            : const Text(
                                "T A P  T O  P L A Y",
                                style: TextStyle(fontSize: 20),
                              );
                      }),
                    ),
                    const AllBarriers()
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                height: 20,
                color: Colors.green,
                width: Get.width,
              ),
            ),
            Container(
              height: 175,
              decoration: const BoxDecoration(
                color: Colors.brown,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(20),
                //   topRight: Radius.circular(20),
                // ),
              ),
              child: const ScoresWidget(),
            )
          ],
        ),
      ),
    );
  }
}
