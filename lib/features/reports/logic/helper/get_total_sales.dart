import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';

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
    final saleProfit = sale.soldProducts.fold<double>(0, (innerSum, product) {
      return innerSum +
          ((product.sellingPrice - product.buyingPrice) * product.quantity);
    });
    return sum + saleProfit;
  });
}
