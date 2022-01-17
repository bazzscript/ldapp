import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ldapp/core/database.dart';
import 'package:ldapp/models/contestant/contestant.dart';
import 'package:mongo_dart/mongo_dart.dart';

//Only One Collection Here
const _collectionName = "curtisGames";

//Game Class
class Game extends ChangeNotifier {
  /// GAME ID
  int gameid;

  /// Game Name
  String gamename;

  /// GAME LOGO
  dynamic gameLogo;

  /// SLIDESHOW IMAGES
  dynamic gameStanbySlideshowImages;

  /// Game  Background Image
  dynamic gameBgImage;

  /// Show A Slide Show Screen Or LeaderBoard
  /// This Should Be Implemented With A Switch
  /// So As TO Activate And Deactivate LeaderBoard Easily
  bool isgameLeaderBoardActive;

  /// Game Contestants List / Store
  dynamic gameContestants;

  /// The Current Game
  /// Not Really Needed to be saved in a db but it doesnt hurt to add to db
  int currentGameIndex = 0;

  Game({
    this.gameid = 0,
    this.gamename = 'Curtis Game',
    // this.gameLogo,
    // this.gameBgImage,
    this.gameContestants,
    this.gameStanbySlideshowImages,
    this.isgameLeaderBoardActive = false,
    this.currentGameIndex = 0,
  });

  int currentGameId = 0000;

  //Convert json to game object
  fromJson(Map<String, dynamic> json) {
    gameid = json['gameid'];
    gamename = json['gamename'];
    // gameLogo = json['gameLogo'];
    gameStanbySlideshowImages = json['gameStanbySlideshowImages'];
    // gameBgImage = json['gameBgImage'];
    isgameLeaderBoardActive = json['isgameLeaderBoardActive'];
    gameContestants = json['gameContestants'];
    currentGameIndex = json['currentGameIndex'];
  }

  //convert game object to json
  Map toJson() => <String, dynamic>{
        'gamename': gamename,
        'gameid': gameid,
        // 'gameLogo': gameLogo,
        // 'gameBgImage': gameBgImage,
        'gameContestants': gameContestants,
        'gameStanbySlideshowImages': gameStanbySlideshowImages,
        'isgameLeaderBoardActive': isgameLeaderBoardActive,
        'currentGameIndex': currentGameIndex,
      };

  DBConnection dbConnection = DBConnection();

  logOut() {
    dbConnection.closeConnection();
  }

  ///This Method Creates a new game
  createNewGame(Game game) async {
    var db = await dbConnection.getDatabase();
    var gameCollection = await db.collection(_collectionName);
    //Insert the new game
    await gameCollection.insert(game.toJson());
    logOut();
    notifyListeners();
  }

  ///Get List Of All Games
  final List _gamesList = <Game>[];
  List get gamesList => _gamesList;
  //GET ALL GAMES
  getGameList() async {
    //Get the db connection
    var db = await dbConnection.getDatabase();

    //Get the game collection
    var gameCollection = await db.collection(_collectionName);

    //Get all the games in the collection
    var gameList = await gameCollection.find().toList();

    //Convert the game list to game objects
    for (var game in gameList) {
      Game gameObj = Game();
      await gameObj.fromJson(game);

      //Add the game object to the games list
      _gamesList.add(gameObj);
    }
    logOut();
    notifyListeners();
  }

  //Update The Game Name
  changeGameName({
    required int gameId,
    required String gamename,
  }) async {
    //Get the database
    var db = await dbConnection.getDatabase();

    //Get the game collection
    var gameCollection = await db.collection(_collectionName);

    //Update the game name
    await gameCollection.updateOne(
      where.eq('gameid', gameId),
      modify.set('gamename', gamename),
    );
    logOut();

    //Notify the listeners
    notifyListeners();
  }

  //See game name given game index
  String _activegamename = 'Curtis Game';
  String get activegamename => _activegamename;

  activeGameName(int gameId) async {
    //Get the database
    var db = await dbConnection.getDatabase();

    //Get the game collection
    var gameCollection = await db.collection(_collectionName);

    //Get The Current Loged In Game
    var game = await gameCollection.findOne(where.eq('gameid', gameId));
    Game gameObj = Game();
    await gameObj.fromJson(game);

    _activegamename = gameObj.gamename;
    logOut();

    // notifyListeners();
  }

  // Activate Or Deactivate LeaderBoard Screen
  bool _activeGameLeaderBoardStatus = false;
  bool get activeGameLeaderBoardStatus => _activeGameLeaderBoardStatus;
  activateOrDeactivateGameLeaderBoardScreen({
    required int gameId,
    required bool activateGameLeaderBoard,
  }) async {
    //Get the database
    var db = await dbConnection.getDatabase();

    //Get the game collection
    var gameCollection = await db.collection(_collectionName);

    // Update the game leader board status
    await gameCollection.updateOne(
      where.eq('gameid', gameId),
      modify.set('isgameLeaderBoardActive', activateGameLeaderBoard),
    );

    // GET CURRENT ISGAMELEADERBOARD STATUS AND SET THE VALUE TO _ACTIVEGAMELEADERBOARDSTATUS
    var game = await gameCollection.findOne(where.eq('gameid', gameId));
    Game gameObj = Game();
    await gameObj.fromJson(game);

    _activeGameLeaderBoardStatus = gameObj.isgameLeaderBoardActive;
    logOut();
    notifyListeners();
  }

//Upload Game Slideshow Images
  changeGameSlideshowImages(int gameId) async {
    //Get the database
    var db = await dbConnection.getDatabase();

    //Get the game collection
    var gameCollection = await db.collection(_collectionName);

    //Pick Images For The SlideShow Screen
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      dialogTitle: 'Upload Slideshow Images',
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      try {
        var files = result.paths;
        await gameCollection.updateOne(
          where.eq('gameid', gameId),
          modify.set('gameStanbySlideshowImages', files),
        );
      } catch (e) {
        print(e);
        await gameCollection.updateOne(
          where.eq('gameid', gameId),
          modify.set('gameStanbySlideshowImages', []),
        );
      }
    }

    logOut();

    notifyListeners();
  }

  // get list of game slideshow images
  List<dynamic> _gameSlideshowImages = [];
  List<dynamic> get gameSlideshowImages => _gameSlideshowImages;

  getGameSlideshowImages(int gameId) async {
    //Get the database
    var db = await dbConnection.getDatabase();

    //Get the game collection
    var gameCollection = await db.collection(_collectionName);

    // Get The Current Logged In Game
    var game = await gameCollection.findOne(where.eq('gameid', gameId));
    Game gameObj = Game();
    await gameObj.fromJson(game);

    _gameSlideshowImages = gameObj.gameStanbySlideshowImages;
    logOut();
    notifyListeners();
  }

  //Add New Game Contestant
  addNewGameContestant({
    required int gameId,
    required Contestant contestant,
  }) async {
    //Get the database
    var db = await dbConnection.getDatabase();

    //Get the game collection
    var gameCollection = await db.collection(_collectionName);

    //Get the Game Given The Game Id, And Add The New Contestant
    await gameCollection.updateOne(
      where.eq('gameid', gameId),
      modify.push('gameContestants', contestant.toJson()),
    );

// get list of cof game contestants
    // var game = await gameCollection.findOne(where.eq('gameid', gameId));
    // Game gameObj = Game();
    // await gameObj.fromJson(game);

    // _gameContestants = gameObj.gameContestants;

    logOut();

    //Notify the listeners
    notifyListeners();
  }

  // Create A Stream That Gets A list of all the contestants
  Stream<List<Contestant>> get sortedContestantsStream =>
      _sortedContestantsListController.stream;
  final _sortedContestantsListController = StreamController<List<Contestant>>();

  // Get All Contestants
  getSortedGameContestantsList(int gameId) async {
    //Get the database
    var db = await dbConnection.getDatabase();

    //Get the game collection
    var gameCollection = await db.collection(_collectionName);

    //Get the Game Given The Game Id, And Add The New Contestant
    var game = await gameCollection.findOne(where.eq('gameid', gameId));
    Game gameObj = Game();
    await gameObj.fromJson(game);

    //Sort the by thier total Score
    gameObj.gameContestants
        .sort((a, b) => b.totalScore.compareTo(a.totalScore));
    _sortedContestantsListController.sink.add(gameObj.gameContestants);
    logOut();
  }

  ///Get A Sorted List Of All Game Contestants
  ///This is best suited for the leaderboard screen
  ///This is Sorted based on totalscore
  // List _sortedContestantsList = <Contestant>[];
  // List get sortedContestantsList => _sortedContestantsList;
  // getSortedGameContestantsList(int gameId) async {
  //   var db = await dbConnection.getDatabase();
  //   var gameCollection = await db.collection(_collectionName);
  //   var game = await gameCollection.findOne(where.eq('gameid', gameId));
  //   Game gameObj = Game();
  //   await gameObj.fromJson(game);
  //   Contestant contestant = Contestant();
  //   var gclist = await gameObj.gameContestants
  //       .map((e) => contestant.fromJson(e))
  //       .toList();

  //   List<dynamic> contestants = gclist;

  //   // sort list of contestant based on thier totalscore
  //   contestants.sort((a, b) => b.totalScore.compareTo(a.totalScore));
  //   _sortedContestantsList = contestants;

  //   logOut();

  //   notifyListeners();
  // }

  /// et unsorted List Of All Game Contestants
  /// This is tailored for the home screen
  List _gameContestantsList = <Contestant>[];
  List get gameContestantsList => _gameContestantsList;
  getGameContestantsList(int gameId) async {
    // Get the database
    var db = await dbConnection.getDatabase();

    // Get the game collection
    var gameCollection = await db.collection(_collectionName);

    // Get the Game Given The Game Id
    var game = await gameCollection.findOne(
      where.eq(
        'gameid',
        gameId,
      ),
    );

    Game gameObj = Game();
    await gameObj.fromJson(game);

    Contestant contestant = Contestant();
    var gclist = await gameObj.gameContestants
        .map((e) => contestant.fromJson(e))
        .toList();
    _gameContestantsList = gclist;

    logOut();
    notifyListeners();
  }

  /// Update Game Contestant Name
  updateGameContestantName({
    required int gameId,
    required int contestantIndex,
    required String contestantName,
  }) async {
    // Get the database
    var db = await dbConnection.getDatabase();

    // Get the game collection
    var gameCollection = await db.collection(_collectionName);

    // Given a Game id, Look For A Particular Contestant And Update The Contestant Name
    await gameCollection.updateOne(
      where.eq('gameid', gameId),
      modify.set('gameContestants.$contestantIndex.name', contestantName),
    );
    logOut();
    notifyListeners();
  }

  /// Delete Contestant From ContestantList
  deleteGameContestant({
    required int gameId,
    required int contestantIndex,
  }) async {
    // Get the database
    var db = await dbConnection.getDatabase();

    // Get the game collection
    var gameCollection = await db.collection(_collectionName);

    // Get A Game Given The Game Id
    var game = await gameCollection.findOne(where.eq('gameid', gameId));
    Game gameObj = Game();

    // Convert Json To Game Object
    await gameObj.fromJson(game);
    List gamecontestantlist = gameObj.gameContestants;

    // Remove the Contestant Using The Contestant index
    await gamecontestantlist.removeAt(contestantIndex);

    // Update The Game Contestant List With The New Contestant List
    await gameCollection.updateOne(
      where.eq('gameid', gameId),
      modify.set('gameContestants', gamecontestantlist),
    );

    logOut();
    notifyListeners();
  }

  // Update Contestant Round 1,2,3,4 Scores
  updateGameContestantScores({
    required int gameId,
    required int contestantIndex,
    required String round,
    required int contestantScore,
  }) async {
    // Get the database
    var db = await dbConnection.getDatabase();

    // Get the game collection
    var gameCollection = await db.collection(_collectionName);

    // Get A Game Given The Game Id
    var game = await gameCollection.findOne(where.eq('gameid', gameId));
    Game gameObj = Game();

    // Convert Json To Game Object
    await gameObj.fromJson(game);
    // List gamecontestantlist = gameObj.gameContestants;

    // Update The Game Contestant List With The New Contestant List
    await gameCollection.updateOne(
      where.eq('gameid', gameId),
      modify.set('gameContestants.$contestantIndex.$round', contestantScore),
    );

    logOut();
    notifyListeners();
  }

  // Update Game Contestants TotalScores

  updateGameContestantTotalScores(int gameId) async {
    // Get the database
    var db = await dbConnection.getDatabase();

    // Get the game collection
    var gameCollection = await db.collection(_collectionName);

    // Get A Game Given The Game Id
    var game = await gameCollection.findOne(where.eq('gameid', gameId));
    Game gameObj = Game();

    // Convert Json To Game Object
    await gameObj.fromJson(game);
    Contestant contestant = Contestant();
    var gamecontestantlist = await gameObj.gameContestants
        .map((e) => contestant.fromJson(e))
        .toList();

    // Update the Contestant Using The Contestant index

    for (int i = 0; i < gamecontestantlist.length; i++) {
      gamecontestantlist[i].totalScore = gamecontestantlist[i].round1 +
          gamecontestantlist[i].round2 +
          gamecontestantlist[i].round3 +
          gamecontestantlist[i].round4;
    }

    // Convert back to json and save to db
    var gc = await gamecontestantlist.map((e) => e.toJson()).toList();
    await gameCollection.updateOne(
      where.eq('gameid', gameId),
      modify.set('gameContestants', gc),
    );

    logOut();
    notifyListeners();
  }

  ///Update Contestant prediction
  updateGameContestantPrediction({
    required int gameId,
    required int contestantIndex,
    required int contestantPrediction,
  }) async {
    // Get The Db
    var db = await dbConnection.getDatabase();

    // Get The Game Collection
    var gameCollection = await db.collection(_collectionName);

    // Get The Game Given The Game Id
    var game = await gameCollection.findOne(where.eq('gameid', gameId));
    Game gameObj = Game();

    // Convert The Game From Json To A Game Object
    await gameObj.fromJson(game);
    Contestant contestant = Contestant();

    var gamecontestantlist = await gameObj.gameContestants
        .map((e) => contestant.fromJson(e))
        .toList();

    // Update the Contestant Using The Contestant index
    gamecontestantlist[contestantIndex].prediction = contestantPrediction;

    //Convert Game Object to json and save to db
    var b = await gamecontestantlist.map((e) => e.toJson()).toList();

    // Update The Contestant Prediction
    await gameCollection.updateOne(
      where.eq('gameid', gameId),
      modify.set('gameContestants', b),
    );

    logOut();

    // Notify The Listeners
    notifyListeners();
  }

  ///Toggles Whether A Game Contestant Is On Fire Or Not
  isGameContestantOnFire({
    required int gameId,
    required int contestantIndex,
    required bool isContestantOnFire,
  }) async {
    // Get The Db
    var db = await dbConnection.getDatabase();

    // Get The Game Collection
    var gameCollection = await db.collection(_collectionName);

    // Get The Game Given The Game Id
    var game = await gameCollection.findOne(where.eq('gameid', gameId));
    Game gameObj = Game();

    // Convert The Game From Json To A Game Object
    await gameObj.fromJson(game);
    Contestant contestant = Contestant();

    var gamecontestantlist = await gameObj.gameContestants
        .map((e) => contestant.fromJson(e))
        .toList();

    // Update the Contestant Using The Contestant index
    gamecontestantlist[contestantIndex].isContestantOnFire = isContestantOnFire;

    //Convert back to json and save to db
    var b = await gamecontestantlist.map((e) => e.toJson()).toList();
    await gameCollection.updateOne(
      where.eq('gameid', gameId),
      modify.set('gameContestants', b),
    );

    logOut();
    notifyListeners();
  }
}
