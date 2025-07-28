import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/sales/logic/notifier/select_product_notifier.dart';
import 'package:small_managements/features/sales/model/selected_prodcut_model.dart';

final selectProductProvider =
    StateNotifierProvider<SelectProductProvider, List<SelectedProdcutModel>>(
      (ref) => SelectProductProvider(),
    );

final quantityProvider = StateProvider<int>((ref) => 1);
