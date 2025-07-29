import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/generated/l10n.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.productName,
    required this.price,
    required this.time,
  });
  final String productName;
  final double price;
  final DateTime time;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('${S.of(context).product}: ', style: TextStyle(fontSize: 16)),
            Text(productName, style: TextStyle(fontSize: 16)),
            Spacer(),
            Text('$price LE', style: TextStyle(fontSize: 16)),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              '2 Item',
              style: TextStyle(fontSize: 13, color: AppColors.kPrimeryColor),
            ),
            SizedBox(width: 5),
            Text(
              '$time',
              style: TextStyle(fontSize: 13, color: AppColors.kPrimeryColor),
            ),
          ],
        ),
      ],
    );
  }
}
