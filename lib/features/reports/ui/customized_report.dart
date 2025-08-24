import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/reports/logic/pdf/generate_pdf.dart';
import 'package:small_managements/features/reports/ui/widgets/custom_total_row.dart';
import 'package:small_managements/features/sales/model/sold_product_model.dart';
import 'package:small_managements/generated/l10n.dart';

class CustomizedReport extends StatelessWidget {
  const CustomizedReport({
    super.key,
    required this.totalSales,
    required this.totalProductSold,
    required this.totalProfit,
    required this.startDate,
    required this.endDate,
    required this.soldProducts,
  });

  final double totalSales;
  final double totalProductSold;
  final double totalProfit;
  final String startDate;
  final String endDate;
  final List<SoldProductModel> soldProducts;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).salesReprot),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '${S.of(context).dateRange} : $startDate ${S.of(context).to} $endDate',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              CustomTotalsRow(
                totals: '$totalSales ${S.of(context).LE}',
                label: S.of(context).totalSales,
              ),
              const SizedBox(height: 5),
              CustomTotalsRow(
                totals: '$totalProductSold ${S.of(context).item}',
                label: S.of(context).totalProductSold,
              ),
              const SizedBox(height: 5),
              CustomTotalsRow(
                totals: '$totalProfit ${S.of(context).LE}',
                label: S.of(context).totalProfit,
              ),
              const SizedBox(height: 10),

              // جدول المنتجات
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStatePropertyAll(
                      isDark ? Colors.grey[800] : Colors.grey[300],
                    ),
                    border: TableBorder.all(color: Colors.grey),
                    columns: [
                      DataColumn(label: Text(S.of(context).product)),
                      DataColumn(label: Text(S.of(context).quantity)),
                      DataColumn(label: Text(S.of(context).sellingPrice)),
                      DataColumn(label: Text(S.of(context).totalPrice)),
                    ],
                    rows: soldProducts.map((p) {
                      final qty = p.quantity;
                      final price = p.sellingPrice;
                      final total = qty * price;

                      return DataRow(
                        cells: [
                          DataCell(Text(p.productName)),
                          DataCell(Text("${p.quantity}")),
                          DataCell(Text("${p.sellingPrice} ${S.of(context).LE}")),
                          DataCell(Text("$total ${S.of(context).LE}")),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await generateAndPreviewPdf(
                    totalSales: '$totalSales',
                    totalProductSold: '$totalProductSold',
                    totalProfit: '$totalProfit',
                    startDate: startDate,
                    endDate: endDate,
                    soldProducts: soldProducts,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? AppColors.kBlueElevatedButtonDarkMode
                      : AppColors.kBlueElevatedButtonLightMode,
                ),
                child: Text(
                  S.of(context).exprotReprot,
                  style: TextStyle(
                    color: isDark ? Colors.black : Colors.white,
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
