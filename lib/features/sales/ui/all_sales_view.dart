import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/sales/logic/helper/time_converter.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';
import 'package:small_managements/features/sales/ui/widgets/transaction_item.dart';
import 'package:small_managements/generated/l10n.dart';
class AllSalesView extends ConsumerWidget {
  const AllSalesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saleItem = ref.watch(salesProductProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    S.of(context).allSales,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Expanded(
                child: saleItem.isEmpty
                    ? Center(child: Text(S.of(context).thereIsNoSales))
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return TransactionItem(
                            clientName: saleItem[index].name.isEmpty
                                ? S.of(context).unknown
                                : saleItem[index].name,
                            price: saleItem[index].total,
                            time: formatDateTimeTo12Hour(
                              saleItem[index].dateTime,
                            ),
                            itemCount: saleItem[index].soldProducts.fold<int>(
                              0,
                              (sum, e) => sum + e.quantity,
                            ),
                            sale: saleItem[index],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 5),
                        itemCount: saleItem.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
