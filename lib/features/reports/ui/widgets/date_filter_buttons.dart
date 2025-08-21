import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/reports/logic/helper/get_total_sales.dart';
import 'package:small_managements/features/reports/ui/customized_report.dart';
import 'package:small_managements/features/reports/ui/widgets/filter_date_range.dart';
import 'package:small_managements/generated/l10n.dart';

class DateFilterButtons extends StatelessWidget {
  const DateFilterButtons({
    super.key,
    required this.widget,
    required this.formKey,
  });

  final FilterDateRange widget;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? AppColors.kGreyElevatedButtonDarkMode
                : AppColors.kGreyElevatedButtonLightMode,
          ),

          onPressed: () {
            widget.startDateController.clear();
            widget.endDateController.clear();
          },
          child: Text(
            S.of(context).reset,
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.kBlackTextLightMode,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? AppColors.kBlueElevatedButtonDarkMode
                : AppColors.kBlueElevatedButtonLightMode,
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final startDate = DateTime.parse(widget.startDateController.text);
              final endDate = DateTime.parse(widget.endDateController.text);
              final totalSales = getTotalSalesInRange(
                widget.ref,
                startDate,
                endDate,
              );
              final totalProductsSold = getTotalProductSoldInRange(
                widget.ref,
                startDate,
                endDate,
              );
              final totalProfit = getTotalProfitInRange(
                widget.ref,
                startDate,
                endDate,
              );
              final soldProdcuts = getSoldProductsInRange(widget.ref,startDate,endDate);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomizedReport(
                    totalSales: totalSales,
                    totalProductSold: totalProductsSold,
                    totalProfit: totalProfit,
                    startDate: widget.startDateController.text,
                    endDate: widget.endDateController.text, soldProducts: soldProdcuts,
                  ),
                ),
              );
            }
          },
          child: Text(
            S.of(context).apply,
            style: TextStyle(
              color: isDark ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
