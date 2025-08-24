import 'package:hive/hive.dart';

part 'return_transaction_model.g.dart';

@HiveType(typeId: 7)
class ReturnTransaction {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final List<ReturnedProduct> products;

  @HiveField(3)
  final double totalRefund;

  @HiveField(4)
  final double totalProfitReduced;

  ReturnTransaction({
    required this.id,
    required this.date,
    required this.products,
    required this.totalRefund,
    required this.totalProfitReduced,
  });
}

@HiveType(typeId: 6)
class ReturnedProduct {
  @HiveField(0)
  final String productId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final double profitReduced;

  ReturnedProduct({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.profitReduced,
  });
}
