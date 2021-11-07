import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ldapp/models/contestant/contestant.dart';
part 'game.g.dart';

@HiveType(typeId: 1)
class Game extends ChangeNotifier {
  /// GAME ID
  @HiveField(0)
  int gameid;

  /// Game Name
  @HiveField(1)
  String gamename;

  /// GAME LOGO
  @HiveField(2)
  dynamic gameLogo;

  /// SLIDESHOW IMAGES
  @HiveField(3)
  dynamic gameStanbySlideshowImages;

  /// Game  Background Image
  @HiveField(4)
  dynamic gameBgImage;

  /// Show A Slide Show Screen Or LeaderBoard
  /// This Should Be Implemented With A Switch
  /// So As TO Activate And Deactivate LeaderBoard Easily
  @HiveField(5)
  bool isgameLeaderBoardActive;

  /// Game Contestants List / Store
  @HiveField(6)
  dynamic gameContestants;

  /// The Current Game
  /// Not Really Needed to be saved in a db but it doesnt hurt to add to db
  @HiveField(7)
  int currentGameIndex = 0;

  Game({
    this.gameid = 0,
    this.gamename = 'Curtis Game',
    this.gameLogo,
    this.gameBgImage,
    this.gameContestants,
    this.gameStanbySlideshowImages,
    this.isgameLeaderBoardActive = false,
    // this.currentGameIndex = 0,
  });

  /// GAMES BOX
  ///
  /// (can be compared to an SQL Table but unlike SQL TABLE, a Hive Box Has No Structure)
  final String _gameBox = 'gamebox';

/**
 *  Game Methods To Work With
 */

  ///This Method Creates a new game
  createNewGame(Game game) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }

    box.add(game);
    // print(box);
    notifyListeners();
  }

  ///Get List Of All Games
  List _gamesList = <Game>[];
  List get gamesList => _gamesList;
  getGameList() async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    _gamesList = box.values.toList();
    //

    notifyListeners();
  }

  ///Delete Game From Database
  deleteGame(int gameIndex) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    box.deleteAt(gameIndex);
    notifyListeners();
  }

  ///Update Game Name
  changeGameName({required int gameIndex, required String gamename}) async {
    // final box = Hive.box<Game>(_gameBox);
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    Game? game = box.getAt(gameIndex);
    game!.gamename = gamename;
    box.putAt(gameIndex, game);

    notifyListeners();
  }

  // Activate Or Deactivate LeaderBoard Screen
  bool _activeGameLeaderBoardStatus = false;
  bool get activeGameLeaderBoardStatus => _activeGameLeaderBoardStatus;
  activateOrDeactivateGameLeaderBoardScreen({
    required int gameIndex,
    required bool activateGameLeaderBoard,
  }) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    // final box = Hive.box<Game>(_gameBox);
    Game? game = box.getAt(gameIndex);
    game!.isgameLeaderBoardActive = activateGameLeaderBoard;
    box.putAt(gameIndex, game);
    _activeGameLeaderBoardStatus = game.isgameLeaderBoardActive;

    notifyListeners();
  }

  /// Update Game Logo
  changeGameLogo(int gameIndex) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    Game? games = box.getAt(gameIndex);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      dialogTitle: 'Update Logo',
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      try {
        games!.gameLogo = result.files.single.path;
      } catch (e) {
        games!.gameLogo = result.files.first.path;
      } finally {
        games!.gameLogo = 'curtis';
      }
      box.putAt(gameIndex, games);
    } else {
      games!.gameLogo = 'curtis';
      box.putAt(gameIndex, games);
    }
    notifyListeners();
  }

  ///Change Background Image
  changeGameBgImage(int gameIndex) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    Game? games = box.getAt(gameIndex);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      dialogTitle: 'Change Curtis Software Background Image',
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      try {
        games!.gameBgImage = result.files.single.path;
      } catch (e) {
        games!.gameBgImage = result.files.first.path;
      } finally {
        games!.gameBgImage = 'black';
      }
      box.putAt(gameIndex, games);
    } else {
      games!.gameBgImage = 'black';
      box.putAt(gameIndex, games);
    }
    notifyListeners();
  }

  ///Add New Game Contestant
  addNewGameContestant(
      {required int gameIndex, required Contestant contestant}) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    Game? game = box.getAt(gameIndex);
    game!.gameContestants.add(contestant);
    box.putAt(gameIndex, game);
    notifyListeners();
  }

  ///Get A Sorted List Of All Game Contestants
  ///This is best suited for the leaderboard screen
  ///This is Sorted based on totalscore
  List _sortedContestantsList = <Contestant>[];
  List get sortedContestantsList => _sortedContestantsList;
  getSortedGameContestantsList(int gameIndex) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    Game? game = box.getAt(gameIndex);
    _sortedContestantsList = game!.gameContestants.toList();
    _sortedContestantsList.sort((a, b) => b.totalScore.compareTo(a.totalScore));
    // notifyListeners();
  }

  ///Get unsorted List Of All Game Contestants
  ///This is best suited for the home screen
  List _gameContestantsList = <Contestant>[];
  List get gameContestantsList => _gameContestantsList;
  getGameContestantsList(int gameIndex) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }

    Game? game = box.getAt(gameIndex);
    _gameContestantsList = game!.gameContestants.toList();

    // notifyListeners();
  }

  ///Delete Contestant From ContestantList
  deleteGameContestant(
      {required int gameIndex, required int contestantIndex}) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    Game? game = box.getAt(gameIndex);
    game!.gameContestants.removeAt(contestantIndex);
    box.putAt(gameIndex, game);
    notifyListeners();
  }

  ///Update Contestant Prediction, Round 1,2,3,4 Scores
  updateGameContestantScores({
    required gameIndex,
    required int contestantIndex,
    required String round,
    required int contestantScore,
  }) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    // final box = Hive.box<Game>(_gameBox);

    Game? game = box.getAt(gameIndex);
    // Contestant? contestant = game!.gameContestants[contestantIndex];
    if (round == 'round1') {
      game!.gameContestants[contestantIndex].round1 = contestantScore;
    } else if (round == 'round2') {
      game!.gameContestants[contestantIndex].round2 = contestantScore;
    } else if (round == 'round3') {
      game!.gameContestants[contestantIndex].round3 = contestantScore;
    } else if (round == 'round4') {
      game!.gameContestants[contestantIndex].round4 = contestantScore;
    }

    box.putAt(gameIndex, game!);
    notifyListeners();
  }

  // Update Game Contestants TotalScores
  updateGameContestantTotalScores(int gameIndex) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    Game? game = box.getAt(gameIndex);
    for (int i = 0; i < game!.gameContestants.length; i++) {
      game.gameContestants[i].totalScore = game.gameContestants[i].round1 +
          game.gameContestants[i].round2 +
          game.gameContestants[i].round3 +
          game.gameContestants[i].round4;
    }
    box.putAt(gameIndex, game);
    notifyListeners();
  }

  ///Update Contestant Name
  updateGameContestantName({
    required int gameIndex,
    required int contestantIndex,
    required String contestantName,
  }) async {
    // final box = Hive.box<Game>(_gameBox);
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }

    Game? game = box.getAt(gameIndex);

    game!.gameContestants[contestantIndex].name = contestantName;
    box.putAt(gameIndex, game);
    notifyListeners();
  }

  //See game name given game index
  String _activegamename = 'Curtis Game';
  String get activegamename => _activegamename;

  activeGameName(int gameIndex) async {
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }
    Game? game = box.getAt(gameIndex);
    _activegamename = game!.gamename;
    // notifyListeners();
  }

  ///Update Contestant prediction
  updateGameContestantPrediction({
    required int gameIndex,
    required int contestantIndex,
    required int contestantPrediction,
  }) async {
    // final box = Hive.box<Game>(_gameBox);
    Box<Game> box = await Hive.openBox(_gameBox);

    Game? game = box.getAt(gameIndex);
    game!.gameContestants[contestantIndex].prediction = contestantPrediction;
    box.putAt(gameIndex, game);
    notifyListeners();
  }

  ///Toggles Whether A Game Contestant Is On Fire Or Not
  isGameContestantOnFire({
    required int gameIndex,
    required int contestantIndex,
    required bool isContestantOnFire,
  }) async {
    // final box = Hive.box<Game>(_gameBox);
    Box<Game> box;
    if (Hive.isBoxOpen(_gameBox) == true) {
      box = Hive.box<Game>(_gameBox);
    } else {
      box = await Hive.openBox<Game>(_gameBox);
    }

    Game? game = box.getAt(gameIndex);
    game!.gameContestants[contestantIndex].isContestantOnFire =
        isContestantOnFire;
    box.putAt(gameIndex, game);
    notifyListeners();
  }
}
