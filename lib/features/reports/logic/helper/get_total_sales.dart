import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';
import 'package:small_managements/features/sales/model/sold_product_model.dart';

double getTotalSalesInRange(
  WidgetRef ref,
  DateTime startDate,
  DateTime endDate,
) {
  final salesInRange = ref.watch(salesProductProvider).where((sale) {
    return sale.dateTime.isAfter(
          startDate.subtract(const Duration(seconds: 1)),
        ) &&
        sale.dateTime.isBefore(endDate.add(const Duration(days: 1)));
  });

  return salesInRange.fold<double>(0, (sum, sale) => sum + sale.total);
}

double getTotalProductSoldInRange(
  WidgetRef ref,
  DateTime startDate,
  DateTime endDate,
) {
  final salesInRange = ref.watch(salesProductProvider).where((sale) {
    return sale.dateTime.isAfter(
          startDate.subtract(const Duration(seconds: 1)),
        ) &&
        sale.dateTime.isBefore(endDate.add(const Duration(days: 1)));
  });

  return salesInRange.fold<double>(0, (sum, sale) {
    final saleQuantity = sale.soldProducts.fold<int>(0, (innerSum, product) {
      return innerSum + product.quantity;
    });
    return sum + saleQuantity;
  });
}


double getTotalProfitInRange(
  WidgetRef ref,
  DateTime startDate,
  DateTime endDate,
) {
  final salesInRange = ref.watch(salesProductProvider).where((sale) {
    return sale.dateTime.isAfter(
          startDate.subtract(const Duration(seconds: 1)),
        ) &&
        sale.dateTime.isBefore(endDate.add(const Duration(days: 1)));
  });

  return salesInRange.fold<double>(0, (sum, sale) {
    final totalBeforeDiscount = sale.soldProducts.fold<double>(
      0,
      (innerSum, product) =>
          innerSum + (product.sellingPrice * product.quantity),
    );

    double saleProfit = 0;
    for (final product in sale.soldProducts) {
      final itemTotal = product.sellingPrice * product.quantity;
      final itemCost = product.buyingPrice * product.quantity;
      final itemProfitBeforeDiscount = itemTotal - itemCost;

      // توزيع الخصم حسب نسبة مساهمة المنتج
      final ratio = itemTotal / totalBeforeDiscount;
      final itemDiscount = sale.discount * ratio;

      final itemProfit = itemProfitBeforeDiscount - itemDiscount;
      saleProfit += itemProfit;
    }

    return sum + saleProfit;
  });
}
List<SoldProductModel> getSoldProductsInRange(
  WidgetRef ref,
  DateTime startDate,
  DateTime endDate,
) {
  final salesInRange = ref.watch(salesProductProvider).where((sale) {
    return sale.dateTime.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
           sale.dateTime.isBefore(endDate.add(const Duration(days: 1)));
  });

  final Map<String, SoldProductModel> summary = {};

  for (final sale in salesInRange) {
    for (final product in sale.soldProducts) {
      if (summary.containsKey(product.productName)) {
        final existing = summary[product.productName]!;
        summary[product.productName] = SoldProductModel(
          productName: existing.productName,
          sellingPrice: existing.sellingPrice,
          buyingPrice: existing.buyingPrice,
          quantity: existing.quantity + product.quantity,
        );
      } else {
        summary[product.productName] = SoldProductModel(
          productName: product.productName,
          sellingPrice: product.sellingPrice,
          buyingPrice: product.buyingPrice,
          quantity: product.quantity,
        );
      }
    }
  }

  return summary.values.toList();
}
