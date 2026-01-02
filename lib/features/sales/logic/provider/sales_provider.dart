import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/features/sales/model/sales_model.dart';

final salesProductProvider =StateProvider<List<SalesModel>>((ref) {
  final salesBox = Hive.box<SalesModel>(ksalesBox);
  return salesBox.values.toList().reversed.toList();
});

