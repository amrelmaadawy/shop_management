import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String productName;
  @HiveField(1)
  final String price;
  @HiveField(2)
  final String quantity;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String? image;
  @HiveField(5)
  final int id;
  ProductModel({
  required this.productName,
  required this.price,
  required this.quantity,
  required this.category,
   this.image,
  required this.id,
});

}
