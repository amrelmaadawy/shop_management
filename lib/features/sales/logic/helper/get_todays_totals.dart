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

      // توزيع الخصم بنسبة المساهمة
      final ratio = itemTotal / totalBeforeDiscount;
      final itemDiscount = sale.discount * ratio;

      final itemProfit = itemProfitBeforeDiscount - itemDiscount;
      saleProfit += itemProfit;
    }

    return sum + saleProfit;
  });
}
