import 'package:flutter_riverpod/flutter_riverpod.dart';
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
}

final productProviderNotifier =
    StateNotifierProvider<ProductProvider, List<ProductModel>>(
      (ref) => ProductProvider(),
    );
