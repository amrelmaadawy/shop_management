import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';

DateTime getFirstSaleDate(WidgetRef ref) {
  final sales = ref.watch(salesProductProvider);

  if (sales.isEmpty) {
    return DateTime.now(); 
  }

  sales.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  return sales.first.dateTime;
}
