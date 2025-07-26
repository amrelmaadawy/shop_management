
import 'package:hive_flutter/hive_flutter.dart';
part 'sales_model.g.dart';

@HiveType(typeId: 2)
class SalesModel {
  @HiveField(0)
  final String product;
    @HiveField(1)

  final int quantitySold;
    @HiveField(2)

  final double paid;
    @HiveField(3)

  final DateTime dateTime;
    @HiveField(4)

  final double total;
    @HiveField(5)

  final double change;
    @HiveField(6)

  final String name;
  SalesModel({
    required this.paid,
    required this.product,
    required this.quantitySold,
    required this.dateTime,
    required this.total,
    required this.change,
    required this.name,
  });
}
