import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/reports/logic/sales_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatelessWidget {
  const BarChart({
    super.key,
    required this.data,
  });

  final List<SalesData> data;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
        isVisible: false,
        minimum: 0,
        interval: 50,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries>[
        ColumnSeries<SalesData, String>(
          dataSource: data,
          xValueMapper: (SalesData sales, _) =>
              sales.day,
          yValueMapper: (SalesData sales, _) =>
              sales.sales,
          name: 'Sales',
          color: AppColors.kIncreaseContainerColor,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
          ),
        ),
      ],
    );
  }
}

