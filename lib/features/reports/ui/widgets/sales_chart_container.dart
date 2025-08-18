import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/reports/logic/helper/get_start_end_of_week.dart';
import 'package:small_managements/features/reports/logic/helper/get_total_sales.dart';
import 'package:small_managements/features/reports/ui/widgets/bar_chart.dart';
import 'package:small_managements/generated/l10n.dart';

class SalesChartContainer extends StatelessWidget {
  const SalesChartContainer({super.key, required this.ref});

  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startDate = getWeekStart(today);
    final endDate = getWeekEnd(startDate);

    final totalSales = getTotalSalesInRange(ref, startDate, endDate);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: 440,
          decoration: BoxDecoration(
            color: AppColors.kBorderColor,
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width * 0.94,

          height: 438,
          decoration: BoxDecoration(
            color: AppColors.kBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).sales, style: TextStyle(fontSize: 17)),
                Text(
                  '$totalSales LE',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                BarChart(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
