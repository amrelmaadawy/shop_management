// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReturnTransactionAdapter extends TypeAdapter<ReturnTransaction> {
  @override
  final int typeId = 7;

  @override
  ReturnTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReturnTransaction(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      products: (fields[2] as List).cast<ReturnedProduct>(),
      totalRefund: fields[3] as double,
      totalProfitReduced: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ReturnTransaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.products)
      ..writeByte(3)
      ..write(obj.totalRefund)
      ..writeByte(4)
      ..write(obj.totalProfitReduced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReturnTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReturnedProductAdapter extends TypeAdapter<ReturnedProduct> {
  @override
  final int typeId = 6;

  @override
  ReturnedProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReturnedProduct(
      productId: fields[0] as String,
      name: fields[1] as String,
      quantity: fields[2] as int,
      price: fields[3] as double,
      profitReduced: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ReturnedProduct obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.profitReduced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReturnedProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
