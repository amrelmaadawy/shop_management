import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/generated/l10n.dart';

class CancelProductButton extends StatelessWidget {
  const CancelProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        backgroundColor: isDark
            ? AppColors.kGreyElevatedButtonDarkMode
            : AppColors.kGreyElevatedButtonLightMode,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        S.of(context).cancel,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
      ),
    );
  }
}
