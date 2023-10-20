import 'package:fluttergames/snake/packagesExport/appModulesExport.dart';
import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';

class BlankPixelWidget extends StatelessWidget {
  const BlankPixelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class SnakePixelWidget extends StatelessWidget {
  const SnakePixelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class FoodPixelWidget extends StatelessWidget {
  const FoodPixelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Image.asset("assets/images/food.png"),
    );
  }
}

class SnakeHeadWidget extends StatelessWidget {
  const SnakeHeadWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var watchProvider = ref.watch(snakeNotifier);
        return Transform.rotate(
          angle: watchProvider.snakeHeadAngle,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(3),
            ),
            child: const Icon(
              Icons.play_arrow,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
