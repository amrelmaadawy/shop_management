import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/products/logic/category_notifier.dart';
import 'package:small_managements/features/products/logic/product_notifier.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
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
        GestureDetector(
          onTapDown: (details) async {
  final categories = ref.watch(categoryProvider);
final menuItems = [...categories, 'Add New Category']; // أضفها هنا فقط
  if (menuItems.isEmpty) {
    // ممكن تعرض رسالة لو مفيش تصنيفات لسة
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No categories available')),
    );
    return;
  }


  final selected = await showMenu<String>(
    context: context,
    position: RelativeRect.fromLTRB(
      details.globalPosition.dx,
      details.globalPosition.dy,
      details.globalPosition.dx + 1,
      details.globalPosition.dy + 1,
    ),
    items: menuItems
        .map((e) => PopupMenuItem(value: e, child: Text(e)))
        .toList(),
  );

  if (selected != null) {
    if (selected == 'Add New Category') {
      addCategoryController.clear(); // امسح أي قيمة قديمة

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add category'),
          content: CustomTextFormField(
            controller: addCategoryController,
            keyboardType: TextInputType.text,
            labelText: S.of(context).category,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter The Category';
              }
              return null;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final text = addCategoryController.text.trim();
                if (text.isNotEmpty) {
                  ref.read(categoryProvider.notifier).addCategory(text);
                  Navigator.pop(context);
                }
              },
              child: Text(S.of(context).save),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).cancel),
            ),
          ],
        ),
      );
    } else {
      // حفظ القيمة المختارة
      widget.ref.read(chooseCategoryProvider.notifier).state = selected;
      widget.categoryController.text = selected;
    }
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
              controller: widget.categoryController,
              keyboardType: TextInputType.text,
              labelText: S.of(context).category,
            ),
          ),
        ),
      ],
    );
  }
}
