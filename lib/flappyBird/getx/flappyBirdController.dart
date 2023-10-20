import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlappyBirdController extends GetxController {
  RxDouble birdYaxis = 0.0.obs;

  double time = 0;
  double height = 0;
  double initialHeight = 0;
  RxBool gameHasStarted = false.obs;
  RxDouble barrierXOne = 1.3.obs;
  RxDouble barrierXTwo = 2.8.obs;
  RxDouble barrierXThree = 4.5.obs;
  double barrierResetValue = 1.8;
  double barrierResetCondition = -3.0;

  jump() {
    time = 0;
    initialHeight = birdYaxis.value;
  }

  resetGame() {
    time = 0;
    height = 0;
    initialHeight = 0;
    birdYaxis.value = 0.0;
    barrierXOne.value = 1.3;
    barrierXTwo.value = 2.8;
    barrierXThree.value = 4.5;
  }

  startGame() {
    gameHasStarted.value = true;

    initialHeight = birdYaxis.value;

    Timer.periodic(const Duration(milliseconds: 60), (t) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      birdYaxis.value = initialHeight - height;
      if (barrierXOne < barrierResetCondition) {
        barrierXOne.value = barrierResetValue;
      } else {
        barrierXOne.value -= 0.05;
      }
      if (barrierXTwo < barrierResetCondition) {
        barrierXTwo.value = barrierResetValue;
      } else {
        barrierXTwo.value -= 0.05;
      }
      if (barrierXThree < barrierResetCondition) {
        barrierXThree.value = barrierResetValue;
      } else {
        barrierXThree.value -= 0.05;
      }
      if (birdYaxis > 0.93 || birdYaxis < -0.95) {
        t.cancel();

        gameHasStarted.value = false;
        resetGame();
        debugPrint("Timer is cancelled");
      }
    });
  }
}
