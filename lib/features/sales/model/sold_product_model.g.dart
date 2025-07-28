// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sold_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SoldProductModelAdapter extends TypeAdapter<SoldProductModel> {
  @override
  final int typeId = 3;

  @override
  SoldProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SoldProductModel(
      productName: fields[0] as String,
      price: fields[1] as double,
      quantity: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SoldProductModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoldProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
