import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String productName;
  @HiveField(1)
  final String buyingPrice;
  @HiveField(2)
  final String quantity;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String? image;
  @HiveField(5)
  final int id;
  @HiveField(6)
  final String sellingPrice;
  ProductModel( {
    required this.productName,
    required this.buyingPrice,
    required this.quantity,
    required this.category,
    this.image,
    required this.id,
  required  this.sellingPrice,
  });
}
