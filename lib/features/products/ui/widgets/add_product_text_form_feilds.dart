
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/products/logic/product_notifier.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
import 'package:small_managements/generated/l10n.dart';

class AddProductTextFormFields extends StatelessWidget {
  const AddProductTextFormFields({
    super.key,
    required this.productNameController,
    required this.priceController,
    required this.quantityController,
    required this.categories,
    required this.ref,
    required this.categoryController,
  });

  final TextEditingController productNameController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final List<String> categories;
  final WidgetRef ref;
  final TextEditingController categoryController;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
    CustomTextFormField(
      controller: productNameController,
      keyboardType: TextInputType.text,
      labelText: S.of(context).productName,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter The Poduct Name';
        } else {
          return null;
        }
      },
    ),
    SizedBox(height: 15),
    CustomTextFormField(
      controller: priceController,
      keyboardType: TextInputType.number,
      labelText: S.of(context).price,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter The Price of the Product';
        } else {
          return null;
        }
      },
    ),
    SizedBox(height: 15),
    CustomTextFormField(
      controller: quantityController,
      keyboardType: TextInputType.number,
      labelText: S.of(context).quantity,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter The quantity';
        } else {
          return null;
        }
      },
    ),
    SizedBox(height: 15),
    GestureDetector(
      onTapDown: (details) async {
        final selected = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx + 1,
            details.globalPosition.dy + 1,
          ),
          items: categories
              .map((e) => PopupMenuItem(value: e, child: Text(e)))
              .toList(),
        );
        if (selected != null) {
          ref.read(chooseCategoryProvider.notifier).state =
              selected;
          final category = ref.watch(chooseCategoryProvider);
          categoryController.text = category!;
        }
      },
      child: AbsorbPointer(
        child: CustomTextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter The Category ';
            } else {
              return null;
            }
          },
          controller: categoryController,
          keyboardType: TextInputType.text,
          labelText: S.of(context).category,
        ),
      ),
    ),
    ],);
  }
}

