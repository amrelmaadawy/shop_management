import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/features/products/data/product_local_data.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/generated/l10n.dart';

class ProductProvider extends StateNotifier<List<ProductModel>> {
  final ProductLocalData productLocalData = ProductLocalData();

  ProductProvider() : super([]) {
    loadProducts();
  }
  void loadProducts() {
    state = productLocalData.getAllProducts();
  }

  Future<void> addProduct(ProductModel product, BuildContext context) async {
    final products = productLocalData.getAllProducts();
    final alreadyExists = products.any(
      (p) =>
          p.productName.toLowerCase().trim() ==
          product.productName.toLowerCase().trim(),
    );
    if (alreadyExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).productWithTheSameNameAlreadyExists),
          backgroundColor: Colors.red,
        ),
      );
    }else
    {
 await productLocalData.addProduct(product);
    loadProducts();
    }
   
  }

  Future<void> deletProduct(int index) async {
    await productLocalData.deletProduct(index);
    loadProducts();
  }

  Future<void> updatePrdouct(ProductModel newProduct, int index) async {
    await productLocalData.editProduct(newProduct, index);
    loadProducts();
  }

  Future<void> decreaseProductQuantity(
    String productName,
    int quantityToReduce,
  ) async {
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
      state = box.values.toList();
    }
  }
}
