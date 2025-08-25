import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/features/sales/logic/helper/time_converter.dart';
import 'package:small_managements/features/sales/logic/pdf/print_returned_sales.dart';
import 'package:small_managements/features/sales/model/return_transaction_model.dart';

class ReturnedSalesPage extends StatelessWidget {
  const ReturnedSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final returnBox = Hive.box<ReturnTransaction>(kReturnsBox);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Returned Sales"),
        actions: [
          IconButton(
            onPressed: () {
              // جلب كل المرتجعات من الصندوق
              final transactions = returnBox.values.toList();

              if (transactions.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No returns to print")),
                );
                return;
              }

              // حساب الإجماليات
              final totalRefund = transactions.fold<double>(
                0.0,
                (sum, t) => sum + t.totalRefund,
              );

              final totalProfitReduced = transactions.fold<double>(
                0.0,
                (sum, t) => sum + t.totalProfitReduced,
              );

              final totalProductsReturned = transactions.fold<int>(
                0,
                (sum, t) =>
                    sum +
                    t.products.fold<int>(
                      0,
                      (innerSum, p) => innerSum + p.quantity,
                    ),
              );

              // تحديد التاريخ من أول عملية لأخر عملية
              final startDate = transactions.first.date.toString().split(" ").first;
              final endDate = transactions.last.date.toString().split(" ").first;

              // استدعاء الطباعة
              generateReturnReport(
                totalRefund: totalRefund.toStringAsFixed(2),
                totalProductsReturned: totalProductsReturned.toString(),
                totalProfitReduced: totalProfitReduced.toStringAsFixed(2),
                startDate: startDate,
                endDate: endDate,
                returnTransactions: transactions,
              );
            },
            icon: const Icon(CupertinoIcons.printer),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: returnBox.listenable(),
        builder: (context, Box<ReturnTransaction> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No returns yet."));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final transaction = box.getAt(index)!;
              return Card(
                child: ExpansionTile(
                  title: Text(
                    "Returned on ${formatDateTimeTo12Hour(transaction.date.toLocal())}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Refund: \$${transaction.totalRefund} | Profit Reduced: \$${transaction.totalProfitReduced}",
                  ),
                  children: transaction.products
                      .map((product) {
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text(
                            "quantity: ${product.quantity} | Price: \$${product.price}",
                          ),
                          trailing: Text("Profit -\$${product.profitReduced}"),
                        );
                      })
                      .toList()
                      .reversed
                      .toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
