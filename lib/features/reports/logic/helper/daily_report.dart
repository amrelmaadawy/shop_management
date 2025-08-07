import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:small_managements/features/reports/logic/helper/get_start_end_of_week.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';

class DailyReport {
  final String day;
  final double sales;

  DailyReport({required this.day, required this.sales});
}

List<DailyReport> getWeeklySalesData(WidgetRef ref) {
  final today = DateTime.now();
  final startWeek = getWeekStart(today);
  List<DailyReport> weeklySales = [];
  for (int i = 0; i < 7; i++) {
    final day = startWeek.add(Duration(days: i));
    final daySales = ref.watch(salesProductProvider).where((sales) {
      return sales.dateTime.year == day.year &&
          sales.dateTime.month == day.month &&
          sales.dateTime.day == day.day;
    });
    final totalSale = daySales.fold<double>(0, (sum, sale) => sum + sale.total);
    final dayLabel = DateFormat('E').format(day);
    weeklySales.add(DailyReport(day: dayLabel, sales: totalSale));
  }
  return weeklySales;
}
