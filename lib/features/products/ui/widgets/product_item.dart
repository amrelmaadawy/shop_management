
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/products/ui/add_product.dart';

class ProductItem extends ConsumerWidget {
  const ProductItem( {
    
    super.key,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.index,
    required this.productModel,
    required this.image
  });
  final String productName;
  final String quantity;
  final String price;
  final int index;
  final ProductModel productModel;
  final Widget image;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: image,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                productName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '$price . $quantity in stock',
                style: TextStyle(color: AppColors.kPrimeryColor, fontSize: 14),
              ),
            ],
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
                  title: Text('are you sure u want to delete'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(productProviderNotifier.notifier)
                            .deletProduct(index);
                        Navigator.pop(context);
                      },
                      child: Text('Yes'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('no'),
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
