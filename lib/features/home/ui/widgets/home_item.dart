
import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/generated/l10n.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).TotalSales,
              style: TextStyle(
                color: AppColors.khomeTextColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '\$1,000',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              S.of(context).compareTo,
              style: TextStyle(color: AppColors.khomeTextColor),
            ),
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
                  Text('+16%', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_upward_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
        Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.38,
          height: 150,
          child: Image.asset('assets/images/top sales.png'),
        ),
      ],
    );
  }
}
