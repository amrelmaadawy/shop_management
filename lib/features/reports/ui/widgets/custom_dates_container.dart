import 'package:flutter/widgets.dart';
import 'package:small_managements/core/utils/app_colors.dart';

class CustomDatesContainer extends StatelessWidget {
  const CustomDatesContainer({super.key, required this.date});
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        color: AppColors.kGreyElevatedButtonDarkMode,
      ),
      child: Text(date),
    );
  }
}
