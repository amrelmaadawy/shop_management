

import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/reports/logic/sales_data.dart';
import 'package:small_managements/features/reports/ui/widgets/bar_chart.dart';
import 'package:small_managements/generated/l10n.dart';

class SalesChartContainer extends StatelessWidget {
  const SalesChartContainer({
    super.key,
    required this.data,
  });

  final List<SalesData> data;

  @override
  Widget build(BuildContext context) {
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
                Text(
                  S.of(context).sales,
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  '1234 LE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      ' Last 7 days ',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      '+12%',
                      style: TextStyle(
                        color: AppColors.kincreaseColor,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                BarChart(data: data),
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
