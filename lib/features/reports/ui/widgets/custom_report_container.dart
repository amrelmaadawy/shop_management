
import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';

class CustomReportContainer extends StatelessWidget {
  const CustomReportContainer({
    super.key, required this.title, required this.number, required this.percentage,
  });
final String title;
final String number;
final String percentage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
    
          height: 130,
          decoration: BoxDecoration(
            color: AppColors.kBorderColor,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.445,
    
          height: 128,
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
                  title,
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  number,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                   percentage,
                  style: TextStyle(
                    color: AppColors.kincreaseColor,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
