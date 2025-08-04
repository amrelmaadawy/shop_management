import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';

double getTodayTotalSales(WidgetRef ref) {
  final today = DateTime.now();

  final todaySales = ref.watch(salesProductProvider).where((sale) {
    return sale.dateTime.year == today.year &&
        sale.dateTime.month == today.month &&
        sale.dateTime.day == today.day;
  });

  return todaySales.fold<double>(0, (sum, sale) => sum + sale.total);
}

double getTodayTotalProductSold(WidgetRef ref) {
  final today = DateTime.now();

  final todaySales = ref.watch(salesProductProvider).where((sale) {
    return sale.dateTime.year == today.year &&
        sale.dateTime.month == today.month &&
        sale.dateTime.day == today.day;
  });

  return todaySales.fold<double>(0, (sum, sale) {
    final saleQuantity = sale.soldProducts.fold<int>(0, (innerSum, product) {
      return innerSum + product.quantity;
    });
    return sum + saleQuantity;
  });
}

double getTodayTotalProfit(WidgetRef ref) {
  final today = DateTime.now();

  final todaySales = ref.watch(salesProductProvider).where((sale) {
    return sale.dateTime.year == today.year &&
        sale.dateTime.month == today.month &&
        sale.dateTime.day == today.day;
  });

  return todaySales.fold<double>(0, (sum, sale) {
    final saleProfit = sale.soldProducts.fold<double>(0, (innerSum, product) {
      return innerSum +
          ((product.sellingPrice - product.buyingPrice) * product.quantity);
    });
    return sum + saleProfit;
  });
}
