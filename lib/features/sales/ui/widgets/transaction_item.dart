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
              Text('${S.of(context).client} ', style: TextStyle(fontSize: 16)),
              Text(clientName, style: TextStyle(fontSize: 16)),
              Spacer(),
              Text(
                '$price ${S.of(context).LE}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 5),
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
              SizedBox(width: 5),
              Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.kUnselectedItemDarkMode
                      : AppColors.kUnselectedItemLightMode,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () async {
                  final Map<String, int> quantitiesToReturn = {};

                  final result = await showDialog<Map<String, int>>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("اختيار الكميات المرتجعة"),
                        content: StatefulBuilder(
                          builder: (context, setState) {
                            return SizedBox(
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: sale.soldProducts.length,
                                itemBuilder: (context, index) {
                                  final product = sale.soldProducts[index];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(product.productName),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            final current =
                                                quantitiesToReturn[product
                                                    .productName] ??
                                                0;
                                            if (current > 0) {
                                              quantitiesToReturn[product
                                                      .productName] =
                                                  current - 1;
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        "${quantitiesToReturn[product.productName] ?? 0}",
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            final current =
                                                quantitiesToReturn[product
                                                    .productName] ??
                                                0;
                                            if (current < product.quantity) {
                                              quantitiesToReturn[product
                                                      .productName] =
                                                  current + 1;
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, null),
                            child: const Text("إلغاء"),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                Navigator.pop(context, quantitiesToReturn),
                            child: const Text("تنفيذ"),
                          ),
                        ],
                      );
                    },
                  );

                  if (result != null && result.isNotEmpty) {
                    // هنا بنده بس على اللوجيك
                 returnProducts. returnMultipleProducts(
                      sale: sale,
                      quantitiesToReturn: result,
                      ref: ref,
                    );
                  }
                },
                icon: const Icon(Icons.assignment_return, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
