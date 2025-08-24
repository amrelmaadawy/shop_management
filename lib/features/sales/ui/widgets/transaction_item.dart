import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/sales/logic/provider/select_product_provider.dart';
import 'package:small_managements/features/sales/model/sales_model.dart';
import 'package:small_managements/features/sales/ui/sale_detailes_view.dart';
import 'package:small_managements/generated/l10n.dart';

class TransactionItem extends ConsumerWidget {
  const TransactionItem({
    super.key,
    required this.clientName,
    required this.price,
    required this.time,
    required this.itemCount,
    required this.sale,
  });
  final String clientName;
  final double price;
  final String time;
  final int itemCount;
  final SalesModel sale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final returnProducts = ref.watch(selectProductProvider.notifier);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SaleDetailesView(sale: sale)),
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              Text('${S.of(context).client} ', style: const TextStyle(fontSize: 16)),
              Text(clientName, style: const TextStyle(fontSize: 16)),
              const Spacer(),
              Text(
                '$price ${S.of(context).LE}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                '$itemCount ${S.of(context).item}',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.kUnselectedItemDarkMode
                      : AppColors.kUnselectedItemLightMode,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.kUnselectedItemDarkMode
                      : AppColors.kUnselectedItemLightMode,
                ),
              ),
              const Spacer(),
             IconButton(
  onPressed: () async {
    // نجهز خريطة فاضية للكميات اللي هيرجعها اليوزر
    final Map<String, int> quantitiesToReturn = {};

    // نعرض Dialog عشان المستخدم يحدد الكمية لكل منتج
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('select quantity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: sale.soldProducts.map((soldProduct) {
              final controller = TextEditingController(text: "0");
              return Row(
                children: [
                  Expanded(child: Text(soldProduct.productName)),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "0",
                      ),
                      onChanged: (val) {
                        final qty = int.tryParse(val) ?? 0;
                        if (qty > 0 && qty <= soldProduct.quantity) {
                          quantitiesToReturn[soldProduct.productName] = qty;
                        } else {
                          quantitiesToReturn[soldProduct.productName] = 0;
                        }
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(S.of(context).cancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('confirm'),
            ),
          ],
        );
      },
    );

    // بعد ما اليوزر يختار الكميات نرجع المنتجات
    if (quantitiesToReturn.isNotEmpty) {
      returnProducts.returnProductsFromSale(
        sale: sale,
        quantitiesToReturn: quantitiesToReturn,
        ref: ref,
        context: context,
      );
    }
  },
  icon: const Icon(Icons.assignment_return, color: Colors.red),
)

            ],
          ),
        ],
      ),
    );
  }
}
