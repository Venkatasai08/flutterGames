// To parse this JSON data, do
//
//     final snakeGameOverModel = snakeGameOverModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

SnakeGameOverModel snakeGameOverModelFromJson(String str) =>
    SnakeGameOverModel.fromJson(json.decode(str));

String snakeGameOverModelToJson(SnakeGameOverModel data) =>
    json.encode(data.toJson());

class SnakeGameOverModel {
  final String userId;
  final String name;
  final int score;

  SnakeGameOverModel({
    required this.userId,
    required this.name,
    required this.score,
  });

  factory SnakeGameOverModel.fromJson(Map<String, dynamic> json) =>
      SnakeGameOverModel(
        userId: json["userId"],
        name: json["name"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "score": score,
      };

  factory SnakeGameOverModel.fromDocument(DocumentSnapshot document) {
    String userId = document.get("userId");
    String name = document.get("name");
    int score = document.get("score");
    return SnakeGameOverModel(
      userId: userId,
      name: name,
      score: score,
    );
  }
}
