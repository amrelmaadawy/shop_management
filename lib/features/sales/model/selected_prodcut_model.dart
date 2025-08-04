import 'package:small_managements/features/products/model/product_model.dart';

class SelectedProdcutModel {
  ProductModel product;
  int quantity;
  DateTime dateTime;
  SelectedProdcutModel({required this.product, required this.quantity,required this.dateTime});
  double get totalPrice => double.parse(product.sellingPrice) * quantity;

  SelectedProdcutModel copyWith({int? quantity}) {
    return SelectedProdcutModel(
      dateTime: dateTime,
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}
