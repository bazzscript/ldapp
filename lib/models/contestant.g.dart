// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contestant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContestantAdapter extends TypeAdapter<Contestant> {
  @override
  final int typeId = 0;

  @override
  Contestant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contestant(
      id: fields[0] as int,
      name: fields[1] as String,
      round1: fields[2] as int,
      round2: fields[3] as int,
      round3: fields[4] as int,
      round4: fields[5] as int,
      totalScore: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Contestant obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.round1)
      ..writeByte(3)
      ..write(obj.round2)
      ..writeByte(4)
      ..write(obj.round3)
      ..writeByte(5)
      ..write(obj.round4)
      ..writeByte(6)
      ..write(obj.totalScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContestantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
