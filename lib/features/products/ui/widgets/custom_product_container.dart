import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';

class CustomProductContainer extends StatelessWidget {
  const CustomProductContainer({super.key,required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.kGreyElevatedButtonDarkMode,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(text,style: TextStyle(fontSize: 15),),
            SizedBox(width: 5),
            Icon(Icons.arrow_drop_down_sharp, size: 18),
          ],
        ),
      ),
    );
  }
}
