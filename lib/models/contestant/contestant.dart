import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'contestant.g.dart';

// @HiveType()
@HiveType(typeId: 0)
class Contestant extends ChangeNotifier {
  // @override
  // int get typeId => 0;

  // @HiveField(0)
  int id;

  //Contestants Name
  // @HiveField(1)
  String name;

  /// Contestant Score Round 1
  // @HiveField(2)
  int round1;

  /// Contestant Score Round 2
  // @HiveField(3)
  int round2;

  /// Contestant Score Round 3
  // @HiveField(4)
  int round3;

  /// Contestant Score Round 4
  // @HiveField(5)
  int round4;

  /// Total Score of Contestant
  // @HiveField(6)
  int totalScore;

  //Prediction
  // @HiveField(7)
  int prediction;

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
}
