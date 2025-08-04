import 'package:hive/hive.dart';

part 'sold_product_model.g.dart';

@HiveType(typeId: 3)
class SoldProductModel {
  @HiveField(0)
  final String productName;

  @HiveField(1)
  final double sellingPrice;

  @HiveField(2)
  final int quantity;
@HiveField(3)
  final double buyingPrice;

  SoldProductModel({
    required this.productName,
    required this.sellingPrice,
    required this.quantity,
    required this.buyingPrice,
  });

  double get total => sellingPrice * quantity;
}
