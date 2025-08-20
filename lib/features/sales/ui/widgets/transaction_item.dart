import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/sales/model/sales_model.dart';
import 'package:small_managements/features/sales/ui/sale_detailes_view.dart';
import 'package:small_managements/generated/l10n.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.clientName,
    required this.price,
    required this.time,
    required this.itemCount,
    required this.sale,
  });
  final String clientName;
  final double price;
  final String time;
  final int itemCount;
  final SalesModel sale;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SaleDetailesView(sale: sale)),
        );
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
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.kUnselectedItemDarkMode
                      : AppColors.kUnselectedItemLightMode,
                ),
              ),
              SizedBox(width: 5),
              Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.kUnselectedItemDarkMode
                      : AppColors.kUnselectedItemLightMode,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
