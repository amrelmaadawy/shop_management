import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/reports/logic/helper/get_first_sale_date.dart';
import 'package:small_managements/features/reports/logic/helper/get_total_sales.dart';
import 'package:small_managements/features/reports/logic/helper/top_selling_products.dart';
import 'package:small_managements/features/reports/logic/pdf/generate_pdf.dart';
import 'package:small_managements/features/reports/ui/widgets/custom_report_container.dart';
import 'package:small_managements/features/reports/ui/widgets/filter_date_range.dart';
import 'package:small_managements/features/reports/ui/widgets/sales_chart_container.dart';
import 'package:small_managements/features/reports/ui/widgets/top_selling_item.dart';
import 'package:small_managements/generated/l10n.dart';

class ReportsView extends ConsumerStatefulWidget {
  const ReportsView({super.key});

  @override
  ConsumerState<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends ConsumerState<ReportsView> {
  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final startDate = getFirstSaleDate(ref);
    final endDate = DateTime.now();

    final totalSales = getTotalSalesInRange(ref, startDate, endDate);
    final totalProductsSold = getTotalProductSoldInRange(
      ref,
      startDate,
      endDate,
    );
    final totalProfit = getTotalProfitInRange(ref, startDate, endDate);
    final topSellingItems = getTopSellingProducts(ref);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          S.of(context).reports,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
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
                      ),
                      Positioned(
                        right: 40,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return FilterDateRange(
                                  ref: ref,
                                  startDateController: startDateController,
                                  endDateController: endDateController,
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.calendar_month_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomReportContainer(
                      title: S.of(context).totalSales,
                      number: '$totalSales LE',
                    ),
                    CustomReportContainer(
                      title: S.of(context).totalProductSold,
                      number: '$totalProductsSold',
                    ),
                  ],
                ),
                SizedBox(height: 15),
                CustomReportContainer(
                  width: MediaQuery.of(context).size.width * 0.95,
                  title: S.of(context).totalProfit,
                  number: '$totalProfit LE',
                ),
                SizedBox(height: 15),
                SalesChartContainer(ref: ref),
                SizedBox(height: 15),
                Text(
                  S.of(context).topSellingItems,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemCount: topSellingItems.length,
                  itemBuilder: (context, index) => TopSellingItem(
                    productName: topSellingItems[index].key.productName,
                    image: topSellingItems[index].key.image != null
                        ? Image.file(File(topSellingItems[index].key.image!))
                        : Image.asset('assets/images/product.png'),
                    quantitySold: topSellingItems[index].value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
