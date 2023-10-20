import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttergames/common/commonTryCatch.dart';
import 'package:fluttergames/snake/models/snakeGameOverModel.dart';
import 'package:fluttergames/snake/packagesExport/appModulesExport.dart';
import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';
import 'package:uuid/uuid.dart';

extension Extension on TextEditingController {
  String isValidName() {
    if (text.isEmpty) {
      return "Name shouldn't be empty";
    } else if (text.length < 2) {
      return "Name must be greaterthan 3 charecters";
    }
    return "";
  }
}

final gameOverNotifier = ChangeNotifierProvider<GameOverNotifier>((ref) {
  var snakeWatchNotifier = ref.watch(snakeNotifier);
  return GameOverNotifier(score: snakeWatchNotifier.score);
});

class GameOverNotifier extends ChangeNotifier {
  final int score;
  GameOverNotifier({required this.score});
  var dataBase = FirebaseFirestore.instance;
  Uuid uuid = const Uuid();
  TextEditingController nameController = TextEditingController();

  List<SnakeGameOverModel> highScoresList = [];
  String nameErrorText = "";
  changeNameErrorText(String errorText) {
    nameErrorText = errorText;
    notifyListeners();
  }

  bool isSubmitted = false;

  Future submitScore() async {
    isSubmitted = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    await CommonTryCatch().customTryCatch(callBack: () async {
      String gamgeId = uuid.v1();
      String userId = uuid.v1();

      SnakeGameOverModel data = SnakeGameOverModel(
          userId: userId, name: nameController.text, score: score);
      await dataBase
          .collection("SnakeGameScores")
          .doc(gamgeId)
          .set(data.toJson());
      return "Data sumitted";
    });
    nameController.clear();
    isSubmitted = false;
    notifyListeners();
  }

  Stream<QuerySnapshot> getHighScores() {
    return FirebaseFirestore.instance
        .collection("SnakeGameScores")
        .orderBy("score", descending: true)
        .limit(10)
        .snapshots();
  }
}
