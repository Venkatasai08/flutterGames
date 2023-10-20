import 'dart:convert';

import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';
import 'package:fluttergames/testing/fake_model.dart';
import 'package:http/http.dart' as http;

class FakeRiverPod extends ChangeNotifier {
  bool isLoading = false;
  Future<List<FakeModel>> getFakeData() async {
    isLoading = true;
    notifyListeners();
    try {
      Uri url = Uri.parse("https://jsonplaceholder.typicode.com/todos");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        List<FakeModel> fakeModelList =
            List.from((responseBody as List).map((e) => FakeModel.fromJson(e)));
        isLoading = false;
        notifyListeners();
        return fakeModelList;
      }
      isLoading = false;
      notifyListeners();
      return [];
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return [];
    }
  }
}

class FakeStateRiverPod extends StateNotifier<List<FakeModel>> {
  final Ref ref;
  FakeStateRiverPod({required this.ref}) : super([]);

  getListUpdateState() async {
    state = await ref.read(fakeRiverPod).getFakeData();
    // return state;
  }
}

final fakeRiverPod = ChangeNotifierProvider((ref) => FakeRiverPod());
final fakeStateRiverPod =
    StateNotifierProvider<FakeStateRiverPod, List<FakeModel>>(
        (ref) => FakeStateRiverPod(ref: ref));
