import 'package:fluttergames/snake/packagesExport/appModulesExport.dart';
import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';

class SnakeGridWidget extends ConsumerWidget {
  const SnakeGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var watchProvider = ref.watch(snakeNotifier);

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (watchProvider.isPlaying) {
          if (details.delta.dy > 0 &&
              watchProvider.currentDirection != SnakeDirection.up) {
            watchProvider.currentDirection = SnakeDirection.down;
          } else if (details.delta.dy < 0 &&
              watchProvider.currentDirection != SnakeDirection.down) {
            watchProvider.currentDirection = SnakeDirection.up;
          }
        }
      },
      onHorizontalDragUpdate: (details) {
        if (watchProvider.isPlaying) {
          if (details.delta.dx > 0 &&
              watchProvider.currentDirection != SnakeDirection.left) {
            watchProvider.currentDirection = SnakeDirection.right;
          } else if (details.delta.dx < 0 &&
              watchProvider.currentDirection != SnakeDirection.right) {
            watchProvider.currentDirection = SnakeDirection.left;
          }
        }
      },
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: watchProvider.totalNumberOfSquares,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: watchProvider.rowSize,
        ),
        itemBuilder: (context, index) {
          if (watchProvider.snakePos.contains(index)) {
            if (watchProvider.snakePos.last == index) {
              return const SnakeHeadWidget();
            }
            return const SnakePixelWidget();
          } else if (index == watchProvider.foodPos) {
            return const FoodPixelWidget();
          } else {
            return const BlankPixelWidget();
          }
        },
      ),
    );
  }
}
