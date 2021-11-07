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

  /*
  final String _contestantBox = 'contestants';

  ///Create a new contestant
  //CREATE
  addNewContestant(Contestant contestant) async {
    var box = await Hive.openBox<Contestant>(_contestantBox);
    box.add(contestant);
    notifyListeners();
  }

  ///Get A Sorted List Of All Contestants
  //READ
  ///I think this is best suited for the leaderboard screen
  List _contestantsList = <Contestant>[];
  List get contestantsList => _contestantsList;
  getContestants() async {
    var box = await Hive.openBox<Contestant>(_contestantBox);
    _contestantsList = box.values.toList();
    _contestantsList.sort((a, b) => b.totalScore.compareTo(a.totalScore));
    notifyListeners();
  }

  ///Get List Of All Contestants for the home screen
  List _contestingList = <Contestant>[];
  List get contestingList => _contestingList;
  getContestingList() async {
    var box = await Hive.openBox<Contestant>(_contestantBox);
    _contestingList = box.values.toList();
    notifyListeners();
  }

  ///Delete Contestant From Database
  //DELETE
  deleteContestant(int index) {
    final box = Hive.box<Contestant>(_contestantBox);
    box.deleteAt(index);
    // getContestingList();
    notifyListeners();
  }

  ///Update Contestant Prediction, Round 1,2,3,4 Scores in the Database
  updateContestantPrediction(int index, String round, int score) {
    final box = Hive.box<Contestant>(_contestantBox);
    Contestant? contestant = box.getAt(index);
    if (round == 'round1') {
      contestant!.round1 = score;
    } else if (round == 'round2') {
      contestant!.round2 = score;
    } else if (round == 'round3') {
      contestant!.round3 = score;
    } else if (round == 'round4') {
      contestant!.round4 = score;
    }
    box.putAt(index, contestant!);
    notifyListeners();
  }


  updateContestantsTotalScores(int index) {
    final box = Hive.box<Contestant>(_contestantBox);
    Contestant? contestant = box.getAt(index);
    contestant!.totalScore = contestant.round1 +
        contestant.round2 +
        contestant.round3 +
        contestant.round4;
    box.putAt(index, contestant);
    notifyListeners();
  }

  ///Update Contestant Name
  updateContestantName(int index, String name) {
    final box = Hive.box<Contestant>(_contestantBox);
    Contestant? contestant = box.getAt(index);
    contestant!.name = name;
    box.putAt(index, contestant);
    notifyListeners();
  }

  ///Update Contestant id
  //Evetually used it to update contestant predictions
  updateContestantId(int index, int id) {
    final box = Hive.box<Contestant>(_contestantBox);
    Contestant? contestant = box.getAt(index);
    contestant!.id = id;
    box.putAt(index, contestant);
    notifyListeners();
  }
  */
}
