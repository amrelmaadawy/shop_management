import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/products/ui/add_product.dart';
import 'package:small_managements/generated/l10n.dart';

class ProductItem extends ConsumerWidget {
  const ProductItem({
    super.key,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.index,
    required this.productModel,
    required this.image,
  });
  final String productName;
  final String quantity;
  final String price;
  final int index;
  final ProductModel productModel;
  final Widget image;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: SizedBox(width: 80, height: 80, child: image),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.42,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  productName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$price ${S.of(context).LE} . $quantity ${S.of(context).inStock}',
                  style: TextStyle(
                    color: int.parse(quantity) <= 5
                        ? const Color.fromARGB(255, 191, 15, 3)
                        : isDark
                        ? AppColors.kUnselectedItemDarkMode
                        : AppColors.kUnselectedItemLightMode,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddProduct(productModel: productModel, index: index),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(S.of(context).areYouSureYouWantToDelet),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(productProviderNotifier.notifier)
                            .deletProduct(index);
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).yes),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.of(context).no),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.delete_forever_outlined,
              color: Colors.red.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
