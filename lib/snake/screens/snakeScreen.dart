import 'package:flutter/services.dart';
import 'package:fluttergames/snake/packagesExport/appModulesExport.dart';
import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';
import 'package:fluttergames/snake/riverPod/gameOverRiverPod.dart';
import 'package:fluttergames/snake/widgets/highScoresWidget.dart';

class SnakeScreen extends ConsumerStatefulWidget {
  const SnakeScreen({super.key});

  @override
  ConsumerState<SnakeScreen> createState() => _SnakeScreenState();
}

class _SnakeScreenState extends ConsumerState<SnakeScreen> {
  late SnakeNotifier readSnakeProvider;
  late GameOverNotifier readGameOverNotifier;
  @override
  void initState() {
    super.initState();
    readSnakeProvider = ref.read(snakeNotifier);
    readGameOverNotifier = ref.read(gameOverNotifier);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      readSnakeProvider.changeFoodLoacation();
    });
    readGameOverNotifier.getHighScores();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKey: (event) {
            if (event.isKeyPressed(LogicalKeyboardKey.space)) {
              if (readSnakeProvider.isPlaying) {
                readSnakeProvider.pauseGame();
              } else {
                if (readSnakeProvider.isGameOver) {
                  readSnakeProvider.startGame(context);
                } else {
                  readSnakeProvider.startGame(context);
                }
              }
            }
            if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
              if (readSnakeProvider.currentDirection != SnakeDirection.up) {
                readSnakeProvider.changeCurrentDirection(SnakeDirection.down);
              }
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
              if (readSnakeProvider.currentDirection != SnakeDirection.down) {
                readSnakeProvider.changeCurrentDirection(SnakeDirection.up);
              }
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              if (readSnakeProvider.currentDirection != SnakeDirection.right) {
                readSnakeProvider.changeCurrentDirection(SnakeDirection.left);
              }
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              if (readSnakeProvider.currentDirection != SnakeDirection.left) {
                readSnakeProvider.changeCurrentDirection(SnakeDirection.right);
              }
            }
          },
          child: Center(
            child: SizedBox(
              width: screenWidth > 350 ? 350 : screenWidth,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Consumer(builder: (context, value, child) {
                                  return Text(
                                    value.watch(snakeNotifier).isPlaying
                                        ? "Pause"
                                        : "Play",
                                    style: const TextStyle(fontSize: 15),
                                  );
                                }),
                                const SizedBox(
                                  height: 10,
                                ),
                                Consumer(builder: (context, value, child) {
                                  return Text(
                                    "${value.watch(snakeNotifier).score}",
                                    style: const TextStyle(fontSize: 45),
                                  );
                                }),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Score",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                              flex: 5, child: SnakeHighScoresWidget())
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SnakeGridWidget(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      // color: Colors.green,
                      child: Center(
                        child: Consumer(builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (readSnakeProvider.isPlaying) {
                                      readSnakeProvider.pauseGame();
                                    } else {
                                      if (readSnakeProvider.isGameOver) {
                                        readSnakeProvider.startGame(context);
                                      } else {
                                        readSnakeProvider.startGame(context);
                                      }
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(3),
                                    padding: const EdgeInsets.all(10),
                                    color: Colors.white.withOpacity(0.2),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          value.watch(snakeNotifier).isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 45,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
