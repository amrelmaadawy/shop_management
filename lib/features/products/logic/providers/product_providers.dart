
import 'package:flutter_riverpod/legacy.dart';
import 'package:small_managements/features/products/logic/notifier/product_notifier.dart';
import 'package:small_managements/features/products/model/product_model.dart';

final productProviderNotifier =
    StateNotifierProvider<ProductProvider, List<ProductModel>>(
      (ref) => ProductProvider(),
    );
final pickImageProvider = StateProvider<String?>((ref) => null);
final chooseCategoryProvider = StateProvider<String?>((ref) => null);
final searchProvider = StateProvider<String>((ref) => '');
