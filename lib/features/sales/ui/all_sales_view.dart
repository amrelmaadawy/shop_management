import 'package:flutter/material.dart';
import 'package:small_managements/features/sales/logic/helper/time_converter.dart';
import 'package:small_managements/features/sales/model/sales_model.dart';
import 'package:small_managements/features/sales/ui/widgets/transaction_item.dart';

class AllSalesView extends StatelessWidget {
  const AllSalesView({super.key, required this.saleItem});
  final List<SalesModel> saleItem;
  @override
  Widget build(BuildContext context) {
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
                    'All Sales',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.83,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return saleItem.isEmpty
                        ? Center(child: Text('There is no sales today'))
                        : TransactionItem(
                            clientName: saleItem[index].name.isEmpty
                                ? 'Unknown'
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
                  separatorBuilder: (context, index) => SizedBox(height: 5),
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
