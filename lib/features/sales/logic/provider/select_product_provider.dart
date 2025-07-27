import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/sales/logic/notifier/select_product_notifier.dart';

final selectProductProvider =
    StateNotifierProvider<SelectProductProvider, List<ProductModel>>(
      (ref) => SelectProductProvider(),
    );
