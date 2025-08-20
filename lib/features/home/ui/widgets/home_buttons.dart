import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/ui/add_product.dart';
import 'package:small_managements/features/sales/ui/make_sale.dart';
import 'package:small_managements/generated/l10n.dart';

class HomeButtons extends StatefulWidget {
  const HomeButtons({super.key});

  @override
  State<HomeButtons> createState() => _HomeButtonsState();
}

class _HomeButtonsState extends State<HomeButtons> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? AppColors.kBlueElevatedButtonDarkMode
                : AppColors.kBlueElevatedButtonLightMode,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProduct()),
            );
          },
          child: Text(
            S.of(context).addProduct,
            style: TextStyle(
              color: isDark ? AppColors.kBlackTextLightMode : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? AppColors.kGreyElevatedButtonDarkMode
                : AppColors.kGreyElevatedButtonLightMode,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MakeSale()),
            );
          },
          child: Text(
            S.of(context).makeSale,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.kBlackTextLightMode,
            ),
          ),
        ),
      ],
    );
  }
}
