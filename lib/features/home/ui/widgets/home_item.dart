import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    required this.title,
    required this.numbers,
    required this.imagePath,
  });
  final String title;
  final String numbers;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isDark
                    ? AppColors.kUnselectedItemDarkMode
                    : AppColors.kUnselectedItemLightMode,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              numbers,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          
          
          ],
        ),
        Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.38,
          height: 150,
          child: Image.asset(imagePath),
        ),
      ],
    );
  }
}
