import 'package:hive_flutter/hive_flutter.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/features/products/model/product_model.dart';

class ProductLocalData {
  final box = Hive.box<ProductModel>(productBox);
  List<ProductModel> getAllProducts() {
    return box.values.toList();
  }

  Future<void> addProduct(ProductModel product) async {
    await box.add(product);
  }

  
  Future<void> deletProduct(int index) async {
    await box.deleteAt(index);
  }
  
  Future<void> editProduct(ProductModel newProduct, int index) async {
    await box.putAt(index,newProduct);
  }
}
