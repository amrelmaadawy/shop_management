import 'package:flutter/material.dart';
import 'package:small_managements/features/sales/ui/make_sale.dart';
import 'package:small_managements/features/sales/ui/widgets/custom_sales_container.dart';
import 'package:small_managements/features/sales/ui/widgets/total_profit_today.dart';
import 'package:small_managements/features/sales/ui/widgets/transaction_item.dart';
import 'package:small_managements/generated/l10n.dart';

class SalesView extends StatelessWidget {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context) {
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
                    title: S.of(context).totalSalesToday,
                    num: '1250 LE',
                  ),
                  CustomSalesContainer(
                    title: S.of(context).totalProductSold,
                    num: '50',
                  ),
                ],
              ),
              SizedBox(height: 15),
              TotalProfitToday(),
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
                    return TransactionItem();
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
