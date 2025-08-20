import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';

class CustomReportContainer extends StatelessWidget {
  const CustomReportContainer({
    super.key,
    required this.title,
    required this.number,
    this.width,
  });
  final String title;
  final String number;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: width ?? MediaQuery.of(context).size.width * 0.45,
          height: 128,
          decoration: BoxDecoration(
            border: Border.all(color:AppColors.kGreyElevatedButtonDarkMode, width: 1),
            color: isDark
                ? AppColors.kGreyElevatedButtonDarkMode
                : AppColors.kGreyElevatedButtonLightMode,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 17)),
                Text(
                  number,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
