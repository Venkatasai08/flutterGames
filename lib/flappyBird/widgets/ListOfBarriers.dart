import 'package:flutter/material.dart';
import 'package:fluttergames/flappyBird/getx/flappyBirdController.dart';
import 'package:fluttergames/flappyBird/widgets/barrier.dart';
import 'package:get/get.dart';

class AllBarriers extends GetView<FlappyBirdController> {
  const AllBarriers({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          UpAndDownBarrier(
              barrierXvalue: controller.barrierXOne.value,
              upBarrierHeight: 180,
              downBarrierHeight: 220),
          UpAndDownBarrier(
              barrierXvalue: controller.barrierXTwo.value,
              upBarrierHeight: 220,
              downBarrierHeight: 180),
          UpAndDownBarrier(
              barrierXvalue: controller.barrierXThree.value,
              upBarrierHeight: 130,
              downBarrierHeight: 270)
        ],
      );
    });
  }
}
