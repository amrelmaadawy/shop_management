
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_managements/features/reports/logic/pdf/generate_pdf.dart';

class PrintIcon extends StatelessWidget {
  const PrintIcon({
    super.key,
    required this.totalSales,
    required this.totalProductsSold,
    required this.totalProfit,
    required this.startDate,
    required this.endDate,
  });

  final double totalSales;
  final double totalProductsSold;
  final double totalProfit;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        onPressed: () async {
          
            await generateAndPreviewPdf(
              totalSales: '$totalSales',
              totalProductSold: '$totalProductsSold',
              totalProfit: '$totalProfit',
              startDate:
                  '${startDate.year}-${startDate.month}-${startDate.day}',
              endDate:
                  '${endDate.year}-${endDate.month}-${endDate.day}',
            );
          
        },
        icon: Icon(CupertinoIcons.printer),
      ),
    );
  }
}
