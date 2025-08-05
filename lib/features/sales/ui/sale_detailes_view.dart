import 'package:flutter/material.dart';
import 'package:small_managements/features/sales/logic/helper/time_converter.dart';
import 'package:small_managements/features/sales/model/sales_model.dart';

class SaleDetailesView extends StatelessWidget {
  const SaleDetailesView({super.key, required this.sale});
  final SalesModel sale;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sale Detailes')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Client Name: ${sale.name.isEmpty ? 'unKnown' : sale.name}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'Total price of items: ${sale.total}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'total paid price: ${sale.paid}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'change: ${sale.change}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'time: ${formatDateTimeTo12Hour(sale.dateTime)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'item count: ${sale.soldProducts.fold<int>(0, (sum, e) => sum + e.quantity)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                'items sold ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) => Text(
                    '${sale.soldProducts[index].productName} : ${sale.soldProducts[index].quantity} item',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  itemCount: sale.soldProducts.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
