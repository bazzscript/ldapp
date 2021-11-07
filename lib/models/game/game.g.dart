// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameAdapter extends TypeAdapter<Game> {
  @override
  final int typeId = 1;

  @override
  Game read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Game(
      gameid: fields[0] as int,
      gamename: fields[1] as String,
      gameLogo: fields[2] as dynamic,
      gameBgImage: fields[4] as dynamic,
      gameContestants: fields[6] as dynamic,
      gameStanbySlideshowImages: fields[3] as dynamic,
      isgameLeaderBoardActive: fields[5] as bool,
    )..currentGameIndex = fields[7] as int;
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.gameid)
      ..writeByte(1)
      ..write(obj.gamename)
      ..writeByte(2)
      ..write(obj.gameLogo)
      ..writeByte(3)
      ..write(obj.gameStanbySlideshowImages)
      ..writeByte(4)
      ..write(obj.gameBgImage)
      ..writeByte(5)
      ..write(obj.isgameLeaderBoardActive)
      ..writeByte(6)
      ..write(obj.gameContestants)
      ..writeByte(7)
      ..write(obj.currentGameIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
