// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todays_total_sold.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodaysTotalSoldAdapter extends TypeAdapter<TodaysTotalSold> {
  @override
  final int typeId = 4;

  @override
  TodaysTotalSold read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodaysTotalSold(
      totalProductSoldToday: fields[1] as int,
      totalSalesToday: fields[0] as int,
      totalProfitToday: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TodaysTotalSold obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.totalSalesToday)
      ..writeByte(1)
      ..write(obj.totalProductSoldToday)
      ..writeByte(2)
      ..write(obj.totalProfitToday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodaysTotalSoldAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
