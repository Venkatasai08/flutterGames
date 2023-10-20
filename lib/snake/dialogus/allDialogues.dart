import 'package:fluttergames/snake/packagesExport/appModulesExport.dart';
import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';
import 'package:fluttergames/snake/riverPod/gameOverRiverPod.dart';

class CustomDialogues {
  showGameOverDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Dialog(
              child: GameOverWidget(),
            ));
  }
}

class GameOverWidget extends ConsumerWidget {
  const GameOverWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readGameOverProvider = ref.read(gameOverNotifier);
    bool isValid() {
      String errorText = readGameOverProvider.nameController.isValidName();
      readGameOverProvider.changeNameErrorText(errorText);
      debugPrint(errorText);
      if (errorText.isEmpty) {
        return true;
      }
      return false;
    }

    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth > 350 ? 280 : screenWidth - 70,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "GameOver",
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer(
                  builder: (context, value, child) {
                    return Text(
                      "Your Score is " "${value.read(snakeNotifier).score}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 17),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Consumer(builder: (context, value, child) {
                    final watchGameOverProvider = value.watch(gameOverNotifier);
                    return TextField(
                      controller: watchGameOverProvider.nameController,
                      decoration: InputDecoration(
                          labelText: "Name",
                          errorText: watchGameOverProvider.nameErrorText.isEmpty
                              ? null
                              : watchGameOverProvider.nameErrorText),
                    );
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer(builder: (context, value, child) {
                      final gameOverWatch = value.watch(gameOverNotifier);
                      return ElevatedButton(
                          onPressed: () async {
                            if (isValid()) {
                              readGameOverProvider.submitScore().then((value) {
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: gameOverWatch.isSubmitted
                              ? Transform.scale(
                                  scale: 0.5,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text("Submit"));
                    }),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.clear),
                ),
              ))
        ],
      ),
    );
  }
}
