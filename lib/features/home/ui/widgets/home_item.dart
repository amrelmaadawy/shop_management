import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    required this.title,
    required this.numbers,
    required this.description,
    required this.imagePath,
    required this.percentage,
  });
  final String title;
  final String numbers;
  final String description;
  final String imagePath;
  final String percentage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: AppColors.kPrimeryColor, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              numbers,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(description, style: TextStyle(color: AppColors.kPrimeryColor)),
            SizedBox(height: 10),
            Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.kIncreaseContainerColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(percentage),
                  SizedBox(width: 5),
                  Icon(Icons.north_east, size: 18),
                ],
              ),
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
