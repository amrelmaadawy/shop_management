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
  final String image;
  @HiveField(5)
  final int id;
  ProductModel(
   this.category,
   this.price,
   this.productName,
    this.quantity,
    this.image, 
 this.id
  );
}
