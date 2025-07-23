import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:small_managements/core/hive_boxes.dart';

class CategoryNotifier extends StateNotifier<List<String>> {
  CategoryNotifier() : super([]) {
    loadCategories();
  }

  final Box<String> box = Hive.box<String>(categoriesBox);

  void loadCategories() {
    final allCategories = box.values.toList();
    state = allCategories;
  }

  void addCategory(String category) {
    if (!state.contains(category)) {
      box.add(category);
      state = [...state, category];
    }
  }

  void removeCategory(String category) {
    state = state.where((e) => e != category).toList();
  }
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<String>>(
  (ref) => CategoryNotifier(),
);

final selectedCategoryProvider = StateProvider<String?>((ref) => null);
