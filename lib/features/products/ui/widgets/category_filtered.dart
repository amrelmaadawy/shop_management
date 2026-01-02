import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/products/logic/providers/category_providers.dart';
import 'package:small_managements/features/products/model/category_model.dart';
import 'package:small_managements/features/products/ui/widgets/custom_product_container.dart';
import 'package:small_managements/generated/l10n.dart';

class CategoryFiltered extends StatelessWidget {
  const CategoryFiltered({
    super.key,
    required this.categories,
    required this.ref,
  });

  final List<CategoryModel> categories;
  final WidgetRef ref;

  // قيمة خاصة لـ "All"
  static const String allCategoriesValue = '__ALL_CATEGORIES__';

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PopupMenuButton<String>(
          // عرض النص الحالي
          child: CustomProductContainer(
            text: selectedCategory == null || selectedCategory == allCategoriesValue
                ? S.of(context).all
                : selectedCategory,
          ),
          onSelected: (value) {
            print('Selected: $value'); // للـ debugging
            // لو اختار "All"، حط null
            if (value == allCategoriesValue) {
              ref.read(selectedCategoryProvider.notifier).state = null;
            } else {
              ref.read(selectedCategoryProvider.notifier).state = value;
            }
          },
          itemBuilder: (_) => [
            // خيار "All" بقيمة خاصة
            PopupMenuItem<String>(
              value: allCategoriesValue,
              child: Row(
                children: [
                  if (selectedCategory == null || selectedCategory == allCategoriesValue)
                    Icon(Icons.check, size: 18),
                  if (selectedCategory == null || selectedCategory == allCategoriesValue)
                    SizedBox(width: 8),
                  Text(S.of(context).all),
                ],
              ),
            ),
            // الفئات الباقية
            ...categories.map(
              (e) => PopupMenuItem<String>(
                value: e.categoryName,
                child: Row(
                  children: [
                    if (selectedCategory == e.categoryName)
                      Icon(Icons.check, size: 18),
                    if (selectedCategory == e.categoryName)
                      SizedBox(width: 8),
                    Text(e.categoryName),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}