import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/features/products/data/product_local_data.dart';
import 'package:small_managements/features/products/model/product_model.dart';

class ProductProvider extends StateNotifier<List<ProductModel>> {
  final ProductLocalData productLocalData = ProductLocalData();

  ProductProvider() : super([]) {
    loadProducts();
  }
  void loadProducts() {
    state = productLocalData.getAllProducts();
  }

  Future<void> addProduct(ProductModel product) async {
    await productLocalData.addProduct(product);
    loadProducts();
  }

  Future<void> deletProduct(int index) async {
    await productLocalData.deletProduct(index);
    loadProducts();
  }

  Future<void> updatePrdouct(ProductModel newProduct, int index) async {
    await productLocalData.editProduct(newProduct, index);
    loadProducts();
  }
  Future<void> decreaseProductQuantity(String productName, int quantityToReduce) async {
  final box = Hive.box<ProductModel>(productBox);

  final index = box.values.toList().indexWhere(
    (product) => product.productName == productName,
  );

  if (index != -1) {
    final product = box.getAt(index)!;
    final currentQuantity = int.parse(product.quantity);
    final updatedProduct = product.copyWith(
      quantity: (currentQuantity - quantityToReduce).toString(),
    );

    await box.putAt(index, updatedProduct);

    /// 👇 ضروري جدًا علشان يحدث UI
    state = box.values.toList();
  }
}


}
