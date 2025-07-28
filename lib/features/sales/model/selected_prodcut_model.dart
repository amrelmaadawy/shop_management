import 'package:small_managements/features/products/model/product_model.dart';

class SelectedProdcutModel {
  ProductModel product;
  int quantity;
  SelectedProdcutModel({required this.product, required this.quantity});
  double get totalPrice => double.parse(product.price)* quantity;

  SelectedProdcutModel copyWith({int? quantity}) {
    return SelectedProdcutModel(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}
