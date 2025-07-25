import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/products/logic/providers/category_providers.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/products/model/category_model.dart';
import 'package:small_managements/features/products/ui/widgets/add_product_text_form_feilds.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
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
      onTap: () async {
        final categories = ref.watch(categoryProvider);
        
        await showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return ListTile(
                      title: Text(category.categoryName),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red.shade900),
                        onPressed: () {
                          ref
                              .read(categoryProvider.notifier)
                              .removeCategory(category,context);
                          Navigator.pop(
                            context,
                          ); 
                        },
                      ),
                      onTap: () {
                        widget.ref.read(chooseCategoryProvider.notifier).state =
                            category.categoryName;
                        widget.categoryController.text = category.categoryName;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text(S.of(context).addNewCategory),
                  onTap: () {
                    Navigator.pop(context);
                    addCategoryController.clear();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(S.of(context).addCategory),
                        content: CustomTextFormField(
                          controller: addCategoryController,
                          keyboardType: TextInputType.text,
                          labelText: S.of(context).category,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).pleaseAddTheCategory;
                            }
                            return null;
                          },
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              final text = addCategoryController.text.trim();
                              if (text.isNotEmpty) {
                                final categoryName = CategoryModel(
                                  categoryName: text,
                                );
                                ref
                                    .read(categoryProvider.notifier)
                                    .addCategory(categoryName);
                                widget.ref
                                        .read(chooseCategoryProvider.notifier)
                                        .state =
                                    text;
                                widget.categoryController.text = text;
                                Navigator.pop(context);
                              }
                            },
                            child: Text(S.of(context).save),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(S.of(context).cancel),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
      child: AbsorbPointer(
        child: CustomTextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return S.of(context).pleaseAddTheCategory;
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
