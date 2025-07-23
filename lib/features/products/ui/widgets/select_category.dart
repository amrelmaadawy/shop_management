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
      onTap: () async {
        final categories = ref.watch(categoryProvider);
        final products = ref.watch(
          productProviderNotifier,
        ); // لازم يكون عندك ده

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
                    final isUsed = products.any(
                      (product) => product.category == category,
                    );

                    return ListTile(
                      title: Text(category),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red.shade900),
                        onPressed: () {
                          if (isUsed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'لا يمكن حذف الفئة لأنها مرتبطة بمنتجات',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                backgroundColor: Colors.red.shade900,
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            ref
                                .read(categoryProvider.notifier)
                                .removeCategory(category);
                            Navigator.pop(
                              context,
                            ); // اختياري لو عايز تقفل بعد الحذف
                          }
                        },
                      ),
                      onTap: () {
                        widget.ref.read(chooseCategoryProvider.notifier).state =
                            category;
                        widget.categoryController.text = category;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('إضافة فئة جديدة'),
                  onTap: () {
                    Navigator.pop(context);
                    addCategoryController.clear();
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
                                ref
                                    .read(categoryProvider.notifier)
                                    .addCategory(text);
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
