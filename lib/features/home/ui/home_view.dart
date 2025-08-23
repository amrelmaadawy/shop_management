import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/home/ui/widgets/home_buttons.dart';
import 'package:small_managements/features/home/ui/widgets/home_item.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/reports/logic/helper/get_total_sales.dart';
import 'package:small_managements/generated/l10n.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, 1);
    final endDate = now;
    final totalSales = getTotalSalesInRange(ref, startDate, endDate);

    final totalProfit = getTotalProfitInRange(ref, startDate, endDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).homeAppBar,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              HomeItem(
                title: S.of(context).totalSalesThisMonth,
                numbers: '$totalSales ${S.of(context).LE}',
                imagePath: 'assets/images/top sales.png',
              ),
              HomeItem(
                title: S.of(context).Totalproduct,
                numbers:
                    '${ref.watch(productProviderNotifier).fold<int>(0, (sum, item) => sum + int.parse(item.quantity))} ${S.of(context).item}',
                imagePath: 'assets/images/sales.png',
              ),
              HomeItem(
                title: '${S.of(context).totalProfit}${S.of(context).thisMonth}',
                numbers: '$totalProfit ${S.of(context).LE}',
                imagePath: 'assets/images/product.png',
              ),
              SizedBox(height: 20),
              HomeButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
