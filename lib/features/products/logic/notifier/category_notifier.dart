import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/products/model/category_model.dart';

class CategoryNotifier extends StateNotifier<List<CategoryModel>> {
  final Ref ref;

  CategoryNotifier(this.ref) : super([]) {
    loadCategories();
  }

  final Box<CategoryModel> box = Hive.box<CategoryModel>(categoriesBox);
  void loadCategories() {
    final allCategories = box.values.toList();
    state = allCategories;
  }

  void addCategory(CategoryModel category) {
    if (!state.contains(category)) {
      box.add(category);
      state = [...state, category];
    }
  }

  void removeCategory(CategoryModel category, BuildContext context) {
    final products = ref.read(productProviderNotifier);

    final isUsed = products.any(
      (product) => product.category == category.categoryName,
    );
    if (isUsed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "This category is used in products and cannot be deleted",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      final index = state.indexOf(category);
      if (index != -1) {
        box.deleteAt(index);
        state = state.where((e) => e != category).toList();
      }
    }
  }
}
