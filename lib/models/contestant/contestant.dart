import 'package:flutter/material.dart';

class Contestant extends ChangeNotifier {
  /// Contestant Id
  int id;

  //Contestants Name
  String name;

  /// Contestant Score Round 1
  int round1;

  /// Contestant Score Round 2
  int round2;

  /// Contestant Score Round 3
  int round3;

  /// Contestant Score Round 4
  int round4;

  /// Total Score of Contestant
  int totalScore;

  /// Prediction of Contestant
  int prediction;

  /// Is Contestant On Fire
  bool isContestantOnFire;

  Contestant({
    this.id = 0,
    this.name = 'Enter a name',
    this.prediction = 0,
    this.round1 = 0,
    this.round2 = 0,
    this.round3 = 0,
    this.round4 = 0,
    this.totalScore = 0,
    this.isContestantOnFire = false,
  });

  /// Convert Json To Contestant Object
  fromJson(Map<String, dynamic> json) {
    return Contestant(
      id: json['id'] as int,
      name: json['name'] as String,
      prediction: json['prediction'] as int,
      round1: json['round1'] as int,
      round2: json['round2'] as int,
      round3: json['round3'] as int,
      round4: json['round4'] as int,
      totalScore: json['totalScore'] as int,
      isContestantOnFire: json['isContestantOnFire'] as bool,
    );
  }
  // fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   prediction = json['prediction'];
  //   round1 = json['round1'];
  //   round2 = json['round2'];
  //   round3 = json['round3'];
  //   round4 = json['round4'];
  //   totalScore = json['totalScore'];
  //   isContestantOnFire = json['isContestantOnFire'];
  // }

  /// Convert Contestant Object To Json
  Map toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'prediction': prediction,
        'round1': round1,
        'round2': round2,
        'round3': round3,
        'round4': round4,
        'totalScore': totalScore,
        'isContestantOnFire': isContestantOnFire,
      };
}
