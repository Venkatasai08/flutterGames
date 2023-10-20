// To parse this JSON data, do
//
//     final fakeModel = fakeModelFromJson(jsonString);

import 'dart:convert';

FakeModel fakeModelFromJson(String str) => FakeModel.fromJson(json.decode(str));

String fakeModelToJson(FakeModel data) => json.encode(data.toJson());

class FakeModel {
  int userId;
  int id;
  String title;
  bool completed;

  FakeModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory FakeModel.fromJson(Map<String, dynamic> json) => FakeModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
