import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';
import 'package:fluttergames/snake/riverPod/gameOverRiverPod.dart';

class SnakeHighScoresWidget extends ConsumerWidget {
  const SnakeHighScoresWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readGameOverProvider = ref.read(gameOverNotifier);
    return Center(
      child: StreamBuilder<QuerySnapshot>(
          stream: readGameOverProvider.getHighScores(),
          builder: (context, snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              var dataSnapshot = snapshot.data!.docs;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("HighScores"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: dataSnapshot.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 7),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Text(
                                      " ${index + 1}) ${dataSnapshot[index]["name"]}")),
                              Expanded(
                                  child:
                                      Text("${dataSnapshot[index]["score"]}")),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
