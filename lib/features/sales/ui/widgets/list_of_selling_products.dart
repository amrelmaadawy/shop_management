import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/sales/logic/provider/select_product_provider.dart';

class ListOfSellingProducts extends ConsumerWidget {
  const ListOfSellingProducts({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
final selectedProducts = ref.watch(selectProductProvider);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectedProducts[index].product.productName),
                  SizedBox(height: 5),
                  Text('individual Price${selectedProducts[index].product.sellingPrice} LE'),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
              ref.read(selectProductProvider.notifier).decreaseQuantity(selectedProducts[index].product);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kGreyElevatedButtonDarkMode,
                  ),
                  child: Text(
                    '-',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Text(
                  '${selectedProducts[index].quantity}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: () {
              ref.read(selectProductProvider.notifier).increaseQuantity(selectedProducts[index].product);
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kGreyElevatedButtonDarkMode,
                  ),
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        childCount: selectedProducts.length,
      ),
    );
  }
}
