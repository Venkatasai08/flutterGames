import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';

class FlappyBirdBarrier extends StatelessWidget {
  final double height;
  const FlappyBirdBarrier({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.green,
          border:
              Border.all(color: const Color.fromARGB(255, 0, 84, 4), width: 5),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}

class UpAndDownBarrier extends StatelessWidget {
  final double barrierXvalue;
  final double upBarrierHeight;
  final double downBarrierHeight;
  const UpAndDownBarrier(
      {super.key,
      required this.barrierXvalue,
      required this.upBarrierHeight,
      required this.downBarrierHeight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment(barrierXvalue, 1.1),
          // duration: const Duration(seconds: 1),
          child: FlappyBirdBarrier(height: downBarrierHeight),
        ),
        Container(
          alignment: Alignment(barrierXvalue, -1.1),
          // duration: const Duration(seconds: 1),
          child: FlappyBirdBarrier(height: upBarrierHeight),
        ),
      ],
    );
  }
}
