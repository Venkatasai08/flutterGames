import 'package:firebase_core/firebase_core.dart';

class CommonTryCatch {
  Future<Map<String, dynamic>> customTryCatch({
    required Function() callBack,
  }) async {
    try {
      String data = callBack();
      return {
        "success": true,
        "message": data,
      };
    } on FirebaseException catch (e) {
      return {
        "success": false,
        "message": "${e.message}",
      };
    } catch (e) {
      return {
        "success": false,
        "message": "$e",
      };
    }
  }
}
