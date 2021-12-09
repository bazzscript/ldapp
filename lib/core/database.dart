// ignore_for_file: avoid_print

import 'package:mongo_dart/mongo_dart.dart';

class DBConnection {
  //Connect to Mongo Database
  static const String _host = "127.0.0.1";
  static const String _port = "27017";
  static const String _dbName = "curtisgame1";

  /// Our App Database
  // final Db _database = await Db("mongodb://$_host:$_port/$_dbName");
  getDatabase() async {
    Db _database = await Db.create("mongodb://$_host:$_port/$_dbName");

    try {
      await _database.open();
      print('Connected to database');
    } catch (e) {
      print(e);
    }
    return _database;
  }

  Future closeConnection() async {
    Db _database = await Db.create("mongodb://$_host:$_port/$_dbName");

    try {
      await _database.close();
      print('connection closed');
    } catch (e) {
      print('disconnection error');

      print(e);
    }
  }
}

// main() async {
//   var db = Db('mongodb://127.0.0.1/mongo_dart-test');
//   await db.open();

//   String _collectionName = "curtisGames";
//   var gameCollection = db.collection(_collectionName);

//   /// Simple update
//   await gameCollection.remove({});

//   print(gameCollection.find().toList());

//   await db.close();
// }
  // final _collectionName = "curtisGames";
  // final _collection = _database.collection(_collectionName);
