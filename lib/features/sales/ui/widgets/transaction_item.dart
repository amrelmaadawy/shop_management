import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/generated/l10n.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.clientName,
    required this.price,
    required this.time,
    required this.itemCount,
  });
  final String clientName;
  final double price;
  final DateTime time;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       
      },
      child: Column(
        children: [
          Row(
            children: [
              Text('${S.of(context).client} ', style: TextStyle(fontSize: 16)),
              Text(clientName, style: TextStyle(fontSize: 16)),
              Spacer(),
              Text('$price LE', style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                '$itemCount Item',
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
      ),
    );
  }
}
