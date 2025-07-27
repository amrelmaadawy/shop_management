import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/products/model/product_model.dart';

class SelectProductProvider extends StateNotifier<List<ProductModel>> {
  SelectProductProvider():super([]);

  void addProduct(ProductModel product) {
    if (!state.any((p) => p.productName == product.productName)) {
      state = [...state, product];
    }
  }

  void removeProduct(ProductModel product) {
    state.where((p) => p.productName != product.productName).toList();
  }

  void clear() => state = [];
  
}
