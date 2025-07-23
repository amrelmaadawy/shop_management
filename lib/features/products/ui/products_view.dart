import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/logic/category_notifier.dart';
import 'package:small_managements/features/products/logic/product_notifier.dart';
import 'package:small_managements/features/products/ui/add_product.dart';
import 'package:small_managements/features/products/ui/widgets/custom_product_container.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
import 'package:small_managements/features/products/ui/widgets/product_item.dart';
import 'package:small_managements/generated/l10n.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController searchController = TextEditingController();
    final categories = ref.watch(categoryProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kAddProductButtonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                S.of(context).products,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter The Poduct Name';
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(Icons.search),
                controller: searchController,
                keyboardType: TextInputType.text,
                labelText: S.of(context).searchProduct,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PopupMenuButton(
                    child: CustomProductContainer(text: S.of(context).category),
                    onSelected: (value) {
                      ref.read(selectedCategoryProvider.notifier).state =
                          value == 'All' ? null : value;
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(value: 'All', child: Text('All')),
                      ...categories.map(
                        (e) => PopupMenuItem(value: e, child: Text(e)),
                      ),
                    ],
                  ),
                  // CustomProductContainer(text: S.of(context).price),
                  // CustomProductContainer(text: S.of(context).stock),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.586,
                child: Consumer(
                  builder: (context, ref, _) {
                    final products = ref.watch(productProviderNotifier);
                    final selectedCateogry = ref.watch(
                      selectedCategoryProvider,
                    );
                    final filtered = selectedCateogry == null
                        ? products
                        : products
                              .where((e) => e.category == selectedCateogry)
                              .toList();
                    return ListView.separated(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
