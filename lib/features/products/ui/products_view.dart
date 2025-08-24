import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/logic/helper/generate_product_pdf.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
          final products = ref.watch(productProviderNotifier);

    TextEditingController searchController = TextEditingController();
    searchController.addListener(() {
      ref.read(searchProvider.notifier).state = searchController.text.trim();
    });
    final categories = ref.watch(categoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).products,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              generateAndPreviewProductPdf(products);
            },
            icon: Icon(CupertinoIcons.printer),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDark
            ? AppColors.kBlueElevatedButtonDarkMode
            : AppColors.kBlueElevatedButtonLightMode,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
        child: Icon(
          Icons.add,
          color: isDark ? AppColors.kBlackTextLightMode : Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
              CategoryFiltered(categories: categories, ref: ref),
              SizedBox(height: 20),
              ListOfProductsView(),
            ],
          ),
        ),
      ),
    );
  }
}
