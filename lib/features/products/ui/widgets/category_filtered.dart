import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/products/logic/notifier/category_notifier.dart';
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
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PopupMenuButton<CategoryModel?>(
          child: CustomProductContainer(text: S.of(context).category),
          onSelected: (value) {
            ref.read(selectedCategoryProvider.notifier).state =
                value?.categoryName;
          },
          itemBuilder: (_) => [
            PopupMenuItem<CategoryModel?>(value: null, child: Text('All')),
            ...categories.map(
              (e) => PopupMenuItem<CategoryModel?>(
                value: e,
                child: Text(e.categoryName),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
