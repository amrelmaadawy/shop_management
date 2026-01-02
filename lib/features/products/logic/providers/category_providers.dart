
import 'package:flutter_riverpod/legacy.dart';
import 'package:small_managements/features/products/logic/notifier/category_notifier.dart';
import 'package:small_managements/features/products/model/category_model.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<CategoryModel>>(
      (ref) => CategoryNotifier(ref),
    );
final selectedCategoryProvider = StateProvider<String?>((ref) => null);
