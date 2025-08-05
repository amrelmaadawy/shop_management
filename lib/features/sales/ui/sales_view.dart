import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/sales/logic/helper/get_todays_totals.dart';
import 'package:small_managements/features/sales/logic/helper/time_converter.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';
import 'package:small_managements/features/sales/ui/make_sale.dart';
import 'package:small_managements/features/sales/ui/widgets/custom_sales_container.dart';
import 'package:small_managements/features/sales/ui/widgets/total_profit_today.dart';
import 'package:small_managements/features/sales/ui/widgets/transaction_item.dart';
import 'package:small_managements/generated/l10n.dart';

class SalesView extends ConsumerWidget {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesProducts = ref.watch(salesProductProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        S.of(context).sales,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MakeSale()),
                          );
                        },
                        icon: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSalesContainer(
                    title: S.of(context).TotalSalesToday,
                    num: '\$${getTodayTotalSales(ref)}',
                  ),
                  CustomSalesContainer(
                    title: S.of(context).totalProductSold,
                    num: '${getTodayTotalProductSold(ref)}',
                  ),
                ],
              ),
              SizedBox(height: 15),
              TotalProfitToday(totalProfitToday: getTodayTotalProfit(ref)),
              SizedBox(height: 15),
              Text(
                S.of(context).recentTransactions,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.37,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TransactionItem(
                      clientName: salesProducts[index].name.isEmpty
                          ? 'Unknown'
                          : salesProducts[index].name,
                      price: salesProducts[index].total,
                      time: formatDateTimeTo12Hour(
                        salesProducts[index].dateTime,
                      ),
                      itemCount: salesProducts[index].soldProducts.fold<int>(
                        0,
                        (sum, e) => sum + e.quantity,
                      ),
                      sale: salesProducts[index],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemCount: salesProducts.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
