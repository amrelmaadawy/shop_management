
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/products/logic/category_notifier.dart';
import 'package:small_managements/features/products/logic/product_notifier.dart';
import 'package:small_managements/features/products/ui/widgets/add_product_text_form_feilds.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
import 'package:small_managements/generated/l10n.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({
    super.key,
    required this.ref,
    required this.addCategoryController,
    required this.widget,
  });

  final WidgetRef ref;
  final TextEditingController addCategoryController;
  final AddProductTextFormFields widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) async {
        final categories = ref.watch(categoryProvider);
        final menuItems = [
          ...categories,
          'Add New Category',
        ]; 
        if (menuItems.isEmpty) {
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
            addCategoryController.clear();
            showDialog(
              // ignore: use_build_context_synchronously
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
                        ref
                            .read(categoryProvider.notifier)
                            .addCategory(text);
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
            widget.ref.read(chooseCategoryProvider.notifier).state =
                selected;
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
    );
  }
}
