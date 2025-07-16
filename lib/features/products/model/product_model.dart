import 'package:hive/hive.dart';
part 'product_model.g.dart';
@HiveType(typeId: 0)
class ProductModel extends HiveObject{
  @HiveField(0)
  final String productName;
    @HiveField(1)

  final int price;
    @HiveField(2)

  final int quantity;
    @HiveField(3)

  final String category;
    @HiveField(4)

  final String image;
  ProductModel(this.category, this.price, this.productName, this.quantity, this.image);
}
