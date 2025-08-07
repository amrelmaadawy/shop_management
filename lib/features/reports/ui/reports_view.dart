import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/reports/logic/helper/get_first_sale_date.dart';
import 'package:small_managements/features/reports/logic/helper/get_total_sales.dart';
import 'package:small_managements/features/reports/logic/helper/sales_data.dart';
import 'package:small_managements/features/reports/ui/widgets/custom_dates_container.dart';
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
  final List<SalesData> data = [
    SalesData('Sat', 150),
    SalesData('Sun', 200),
    SalesData('Mon', 500),
    SalesData('Tue', 300),
    SalesData('Wed', 250),
    SalesData('Thu', 600),
    SalesData('Fri', 50),
  ];
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
                          onPressed: () {},
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
                    CustomDatesContainer(date: 'Today'),
                    CustomDatesContainer(date: 'Current Week'),
                    CustomDatesContainer(date: 'Current Month'),
                  ],
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
                SalesChartContainer(data: data),
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
                  itemCount: 10,
                  itemBuilder: (context, index) => TopSellingItem(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
