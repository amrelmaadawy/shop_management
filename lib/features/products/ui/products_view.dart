
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/logic/providers/category_providers.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/products/ui/add_product.dart';
import 'package:small_managements/features/products/ui/widgets/category_filtered.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/products/ui/widgets/list_of_products.dart';
import 'package:small_managements/generated/l10n.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController searchController = TextEditingController();
    searchController.addListener(() {
      ref.read(searchProvider.notifier).state = searchController.text.trim();
    });
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
                    return S.of(context).pleaseAddProductName;
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
              CategoryFiltered(categories: categories, ref: ref,),
              SizedBox(height: 20),
              ListOfProductsView(),
            ],
          ),
        ),
      ),
    );
  }
}
