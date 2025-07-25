

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/products/logic/notifier/category_notifier.dart';
import 'package:small_managements/features/products/logic/notifier/product_notifier.dart';
import 'package:small_managements/features/products/ui/widgets/product_item.dart';

class ListOfProductsView extends StatelessWidget {
  const ListOfProductsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.586,
      child: Consumer(
        builder: (context, ref, _) {
          final products = ref.watch(productProviderNotifier);
          final selectedCategory = ref.watch(
            selectedCategoryProvider,
          );
          final searchText = ref.watch(searchProvider).toLowerCase();
          final filtered = products.where((product) {
            final matchesCategory =
                selectedCategory == null ||
                product.category == selectedCategory;
            final matchesSearch = product.productName
                .toLowerCase()
                .contains(searchText);
            return matchesSearch & matchesCategory;
          }).toList();
          return filtered.isEmpty
              ? Center(
                  child: Text(
                    'There is no products',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = filtered[index];
                    return ProductItem(
                      price: product.price,
                      image: product.image != null
                          ? Image.file(File(product.image!))
                          : Image.asset('assets/images/product.png'),
                      productName: product.productName,
                      quantity: product.quantity,
                      index: index,
                      productModel: products[index],
                    );
                  },
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 10),
                );
        },
      ),
    );
  }
}
