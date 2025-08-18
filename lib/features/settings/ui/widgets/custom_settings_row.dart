import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';

class CustomSettingsRow extends StatelessWidget {
  const CustomSettingsRow({
    super.key,
    required this.icon,
    required this.text,
    required this.widget,
  });
  final Widget icon;
  final String text;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.kGreyElevatedButtonDarkMode,
          ),
          child: icon,
        ),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 16)),
        Spacer(),
        SizedBox(child: widget),
      ],
    );
  }
}
