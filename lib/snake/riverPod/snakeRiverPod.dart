import 'dart:async';
import 'dart:math';

import 'package:fluttergames/snake/dialogus/allDialogues.dart';
import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';

enum SnakeDirection { up, down, left, right }

final snakeNotifier =
    ChangeNotifierProvider<SnakeNotifier>((ref) => SnakeNotifier());

class SnakeNotifier extends ChangeNotifier {
  int rowSize = 20;
  int totalNumberOfSquares = 440;
  int foodPos = 390;
  List<int> snakePos = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  bool isPlaying = false;
  Timer? timer;
  SnakeDirection currentDirection = SnakeDirection.right;
  double snakeHeadAngle = 2 * pi;
  int gameSpeedInSeconds = 200;
  bool isAteFood = false;
  int score = 0;
  bool isGameOver = false;
  changeCurrentDirection(SnakeDirection direction) {
    currentDirection = direction;
    notifyListeners();
  }

  startGame(BuildContext context) {
    resetGame();
    isPlaying = true;
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(Duration(milliseconds: gameSpeedInSeconds), (t) {
      mekeGameFaster(context);
      moveSnake();

      if (gameOverMethod()) {
        timer!.cancel();
        CustomDialogues().showGameOverDialog(context);
        isGameOver = true;
        isPlaying = false;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  resetGame() {
    if (isGameOver) {
      isGameOver = false;
      gameSpeedInSeconds = 200;
      snakePos = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
      score = 0;
      currentDirection = SnakeDirection.right;
    }
  }

  mekeGameFaster(BuildContext context) {
    if (snakePos.length % 10 == 0 && isAteFood) {
      if (gameSpeedInSeconds <= 80) {
        gameSpeedInSeconds = 65;
      }

      gameSpeedInSeconds -= 40;
      isAteFood = false;
      debugPrint("time is dectreaed");
      startGame(context);
    }
  }

  moveSnake() {
    switch (currentDirection) {
      case SnakeDirection.down:
        {
          //add a new head
          if (snakePos.last + rowSize > totalNumberOfSquares) {
            //Hit the borders of gridview
            snakePos.add(snakePos.last + rowSize - totalNumberOfSquares);
          } else {
            snakePos.add(snakePos.last + rowSize);
          }
          snakeHeadAngle = pi / 2;
        }

        break;
      case SnakeDirection.up:
        {
          //add a new head
          if (snakePos.last < rowSize) {
            //Hit the borders of gridview
            snakePos.add(snakePos.last - rowSize + totalNumberOfSquares);
          } else {
            snakePos.add(snakePos.last - rowSize);
          }
          snakeHeadAngle = -pi / 2;
        }

        break;
      case SnakeDirection.right:
        {
          //add a new head
          if (snakePos.last % rowSize == (rowSize - 1)) {
            //Hit the borders of gridview
            snakePos.add(snakePos.last + 1 - rowSize);
          } else {
            snakePos.add(snakePos.last + 1);
          }
          snakeHeadAngle = pi * 2;
        }

        break;
      case SnakeDirection.left:
        {
          //add a new head
          if (snakePos.last % rowSize == 0) {
            //Hit the borders of gridview
            snakePos.add(snakePos.last - 1 + rowSize);
          } else {
            snakePos.add(snakePos.last - 1);
          }
          snakeHeadAngle = pi;
        }

        break;

      default:
    }
    if (snakePos.last == foodPos) {
      eatFood();
    } else {
      //remove tail
      snakePos.removeAt(0);
    }
  }

  changeFoodLoacation() {
    int tempfoodPos = Random().nextInt(totalNumberOfSquares);
    if (snakePos.contains(tempfoodPos) || tempfoodPos == foodPos) {
      changeFoodLoacation();
    } else {
      foodPos = tempfoodPos;
    }
    notifyListeners();
  }

  eatFood() {
    while (snakePos.contains(foodPos)) {
      isAteFood = true;
      score += 1;
      changeFoodLoacation();
    }
  }

  pauseGame() {
    timer!.cancel();
    isPlaying = false;
    notifyListeners();
  }

  bool gameOverMethod() {
    // This game over when the runs into itself
    // that means this occues when there is duplicate position  in the snakePos list
    List<int> bodyList = snakePos.sublist(0, snakePos.length - 1);
    if (bodyList.contains(snakePos.last)) {
      return true;
    }
    return false;
  }
}
