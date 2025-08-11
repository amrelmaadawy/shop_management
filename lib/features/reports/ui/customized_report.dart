import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/reports/ui/widgets/custom_total_row.dart';

class CustomizedReport extends StatelessWidget {
  const CustomizedReport({
    super.key,
    required this.totalSales,
    required this.totalProductSold,
    required this.totalProfit,
  });
  final double totalSales;
  final double totalProductSold;
  final double totalProfit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Reprot'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Date Range : 1/1/2024 to 2/1/2024',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              CustomTotalsRow(totals: '$totalSales LE', label: 'Total Sales'),
              CustomTotalsRow(
                totals: '$totalProductSold Item',
                label: 'Total Product Sold',
              ),
              CustomTotalsRow(totals: '$totalProfit LE', label: 'Total Profit'),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kAddProductButtonColor,
                ),
                child: Text(
                  'Exprot Reprot',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
