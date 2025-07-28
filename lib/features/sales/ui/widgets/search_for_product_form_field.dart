
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/sales/logic/provider/select_product_provider.dart';

class SearchForProductFormField extends StatelessWidget {
  const SearchForProductFormField({
    super.key,
    required this.ref,
    required this.selectProductController,
  });

  final WidgetRef ref;
  final TextEditingController selectProductController;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<ProductModel>(
      displayStringForOption: (ProductModel option) =>
          option.productName,
      optionsBuilder: (TextEditingValue textEditingValue) {
        return ref
            .read(productProviderNotifier)
            .where(
              (product) => product.productName
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()),
            );
      },
      fieldViewBuilder:
          (
            context,
            selectProductController,
            focusNode,
            onFieldSubmitted,
          ) {
            return CustomTextFormField(
              focusNode: focusNode,
              controller: selectProductController,
              keyboardType: TextInputType.text,
              labelText: 'search for product',
              validator: (v) {
                return null;
              },
            );
          },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 8,
            child: ListView(
              shrinkWrap: true,
              children: options.map((product) {
                return ListTile(
                  title: Text(product.productName),
                  trailing: Text("${product.price} \$"),
                  onTap: () => onSelected(product),
                );
              }).toList(),
            ),
          ),
        );
      },
      onSelected: (ProductModel selectedProduct) {
        ref
            .read(selectProductProvider.notifier)
            .addProduct(selectedProduct);
        selectProductController.clear();
      },
    );
  }
}