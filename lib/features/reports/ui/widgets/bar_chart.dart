import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/reports/logic/helper/daily_report.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends ConsumerWidget {
  const BarChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<DailyReport> dailyReport= getWeeklySalesData(ref);
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(isVisible: false, minimum: 0, interval: 50),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries>[
        ColumnSeries<DailyReport, String>(
          dataSource: dailyReport,
          xValueMapper: (DailyReport sales, _) => sales.day,
          yValueMapper: (DailyReport sales, _) => sales.sales,
          name: 'Sales',
          color: AppColors.kGreyElevatedButtonDarkMode,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
