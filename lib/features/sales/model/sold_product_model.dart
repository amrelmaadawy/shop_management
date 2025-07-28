import 'package:hive/hive.dart';

part 'sold_product_model.g.dart';

@HiveType(typeId: 3)
class SoldProductModel {
  @HiveField(0)
  final String productName;

  @HiveField(1)
  final double price;

  @HiveField(2)
  final int quantity;

  SoldProductModel({
    required this.productName,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;
}
