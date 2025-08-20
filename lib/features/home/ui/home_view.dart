import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/home/ui/widgets/home_buttons.dart';
import 'package:small_managements/features/home/ui/widgets/home_item.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';
import 'package:small_managements/generated/l10n.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                numbers:
                    '${ref.watch(salesProductProvider).fold<double>(0, (sum, item) => sum + item.total)}',
                description: S.of(context).compareTo,
                imagePath: 'assets/images/top sales.png',
                percentage: '+ 16%',
              ),
              HomeItem(
                title: S.of(context).Totalproduct,
                numbers:
                    '${ref.watch(productProviderNotifier).fold<int>(0, (sum, item) => sum + int.parse(item.quantity))}',
                description: S.of(context).itemsInclude,
                imagePath: 'assets/images/sales.png',
                percentage: '+ 2%',
              ),
              HomeItem(
                title: S.of(context).salesSummary,
                numbers: '5000LE',
                description: S.of(context).thisWeek,
                imagePath: 'assets/images/product.png',
                percentage: '+ 10%',
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
