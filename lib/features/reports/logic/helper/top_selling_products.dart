import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';

List<MapEntry<ProductModel, int>> getTopSellingProducts(WidgetRef ref) {
  final allSales = ref.watch(salesProductProvider);
  final allProducts = ref.read(productProviderNotifier); // حسب ما سميت البروفايدر

  final Map<ProductModel, int> productQuantities = {};

  for (final sale in allSales) {
    for (final soldProduct in sale.soldProducts) {
      final product = allProducts.firstWhere((p) => p.productName == soldProduct.productName);

      productQuantities.update(
        product,
        (existingQuantity) => existingQuantity + soldProduct.quantity,
        ifAbsent: () => soldProduct.quantity,
      );
    }
  }

  final sortedProducts = productQuantities.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return sortedProducts.take(3).toList();
}
