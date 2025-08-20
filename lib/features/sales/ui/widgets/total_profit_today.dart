import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/generated/l10n.dart';

class TotalProfitToday extends StatelessWidget {
  const TotalProfitToday({super.key, this.totalProfitToday});
  final double? totalProfitToday;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: AppColors.kGreyElevatedButtonDarkMode),
        borderRadius: BorderRadius.circular(10),
        color: isDark
            ? AppColors.kGreyElevatedButtonDarkMode
            : AppColors.kGreyElevatedButtonLightMode,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(S.of(context).totalProfit, style: TextStyle(fontSize: 15)),
            Text(
              '$totalProfitToday ${S.of(context).LE}',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
