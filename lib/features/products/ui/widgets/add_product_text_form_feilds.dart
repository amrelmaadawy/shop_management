import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/products/ui/widgets/select_category.dart';
import 'package:small_managements/generated/l10n.dart';

class AddProductTextFormFields extends ConsumerStatefulWidget {
  const AddProductTextFormFields({
    super.key,
    required this.productNameController,
    required this.priceController,
    required this.quantityController,
    required this.ref,
    required this.categoryController,
  });

  final TextEditingController productNameController;
  final TextEditingController priceController;

  final TextEditingController quantityController;
  final WidgetRef ref;
  final TextEditingController categoryController;

  @override
  ConsumerState<AddProductTextFormFields> createState() =>
      _AddProductTextFormFieldsState();
}

class _AddProductTextFormFieldsState
    extends ConsumerState<AddProductTextFormFields> {
  @override
  Widget build(BuildContext context) {
    TextEditingController addCategoryController = TextEditingController();

    return Column(
      children: [
        CustomTextFormField(
          controller: widget.productNameController,
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
          controller: widget.priceController,
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
          controller: widget.quantityController,
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
        SelectCategory(ref: ref, addCategoryController: addCategoryController, widget: widget),
      ],
    );
  }
}
