import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';
import 'package:small_managements/features/sales/model/return_transaction_model.dart';
import 'package:small_managements/features/sales/model/sales_model.dart';
import 'package:small_managements/features/sales/model/selected_prodcut_model.dart';
import 'package:small_managements/features/sales/model/sold_product_model.dart';
import 'package:small_managements/features/sales/model/todays_total_sold.dart';
import 'package:small_managements/generated/l10n.dart';

class SelectProductProvider extends StateNotifier<List<SelectedProdcutModel>> {
  SelectProductProvider() : super([]);

  final Box<SalesModel> box = Hive.box<SalesModel>(ksalesBox);
  final Box<TodaysTotalSold> todaySoldBox = Hive.box<TodaysTotalSold>(
    totalSoldToday,
  );
  int totalProductSoldToday = 0;
  int totalSalesToday = 0;
  int totalProfitToday = 0;
  void addProduct(ProductModel product) {
    final existingIndex = state.indexWhere(
      (p) => p.product.productName == product.productName,
    );
    if (existingIndex != -1) {
      final updated = [...state];
      final oldItem = updated[existingIndex];
      updated[existingIndex] = oldItem.copyWith(quantity: oldItem.quantity + 1);
      state = updated;
    } else {
      state = [
        ...state,
        SelectedProdcutModel(
          product: product,
          quantity: 1,
          dateTime: DateTime.now(),
        ),
      ];
    }
  }

  void increaseQuantity(ProductModel product) {
    final index = state.indexWhere(
      (p) => p.product.productName == product.productName,
    );
    if (index != -1) {
      final updated = [...state];
      final oldItem = updated[index];
      updated[index] = oldItem.copyWith(quantity: oldItem.quantity + 1);
      state = updated;
    }
  }

  void decreaseQuantity(ProductModel product) {
    final index = state.indexWhere(
      (p) => p.product.productName == product.productName,
    );
    if (index != -1) {
      final updated = [...state];
      final oldItem = updated[index];

      if (oldItem.quantity > 1) {
        updated[index] = oldItem.copyWith(quantity: oldItem.quantity - 1);
      } else {
        // لو الكمية = 1 و عمل تقليل، نشيل المنتج خالص
        updated.removeAt(index);
      }

      state = updated;
    }
  }

  void removeProduct(ProductModel product) {
    state.where((p) => p.product.productName != product.productName).toList();
  }

  void clear() => state = [];

  double get totalPrice {
    return state.fold(0, (sum, item) => sum + item.totalPrice);
  }

  Future<void> confirmSale({
    required double paid,
    required WidgetRef ref,
    required BuildContext context,
    String? name,
    double discount = 0,
  }) async {
    if (state.isEmpty) return;

    final products = ref.watch(productProviderNotifier); // كل المنتجات

    // تحقق من توفر الكمية قبل الخصم والحفظ
    for (final item in state) {
      final product = products.firstWhere(
        (p) => p.productName == item.product.productName,
        orElse: () => ProductModel(
          productName: '',
          buyingPrice: '0',
          sellingPrice: '0',
          quantity: '0',
          category: '',
          id: 0,
        ),
      );

      if (product.productName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product ${item.product.productName} not found'),
          ),
        );
        return;
      }

      if (item.quantity > int.parse(product.quantity)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(255, 197, 16, 3),
            content: Text(
              '${S.of(context).notEnoughStockFor} ${item.product.productName}.${S.of(context).available} : ${product.quantity}',
            ),
          ),
        );
        Navigator.pop(context);
        return;
      }
    }

    // تجهيز قائمة المنتجات المباعة
    final soldProducts = state.map((item) {
      return SoldProductModel(
        sellingPrice: double.parse(item.product.sellingPrice),
        productName: item.product.productName,
        buyingPrice: double.parse(item.product.buyingPrice),
        quantity: item.quantity,
      );
    }).toList();

    final totalBeforeDiscount = soldProducts.fold<double>(
      0,
      (sum, item) => sum + (item.sellingPrice * item.quantity),
    );

    final totalAfterDiscount = totalBeforeDiscount - discount;

    if (paid < totalAfterDiscount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error Please enter the correct paid amount',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 153, 11, 1),
        ),
      );
      Navigator.pop(context);
      return;
    }

    final change = paid - totalAfterDiscount;

    final totalProfitBeforeDiscount = soldProducts.fold<double>(
      0,
      (sum, item) =>
          sum + ((item.sellingPrice - item.buyingPrice) * item.quantity),
    );

    double totalProfitAfterDiscount = totalProfitBeforeDiscount;
    if (discount > 0 && totalBeforeDiscount > 0) {
      final discountRatio = discount / totalBeforeDiscount;
      totalProfitAfterDiscount =
          totalProfitBeforeDiscount -
          (totalProfitBeforeDiscount * discountRatio);
    }

    final sale = SalesModel(
      soldProducts: soldProducts,
      paid: paid,
      dateTime: DateTime.now(),
      total: totalAfterDiscount,
      change: change,
      name: name ?? '',
      discount: discount,
    );

    totalProductSoldToday = state.fold(0, (sum, item) => sum + item.quantity);
    totalSalesToday = totalAfterDiscount.toInt();
    totalProfitToday = totalProfitAfterDiscount.toInt();

    final todaysTotalSold = TodaysTotalSold(
      totalProductSoldToday: totalProductSoldToday,
      totalSalesToday: totalSalesToday,
      totalProfitToday: totalProfitToday,
    );

    await todaySoldBox.add(todaysTotalSold);
    await box.add(sale);

    for (final item in soldProducts) {
      await ref
          .read(productProviderNotifier.notifier)
          .decreaseProductQuantity(item.productName, item.quantity);
    }

    ref.read(salesProductProvider.notifier).state = box.values
        .toList()
        .reversed
        .toList();

    clear();

    if (context.mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  Future<void> returnProductsFromSale({
  required SalesModel sale,
  required Map<String, int> quantitiesToReturn, // {productName: qty}
  required WidgetRef ref,
  required BuildContext context,
}) async {
  if (quantitiesToReturn.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No quantities selected to return')),
    );
    return;
  }

  final salesBox = Hive.box<SalesModel>(ksalesBox);
  final productsHive = Hive.box<ProductModel>(productBox);
  final returnsBox = Hive.box<ReturnTransaction>(kReturnsBox);

  // 1) Subtotal الأصلي قبل الخصم
  final double originalSubtotal = sale.soldProducts.fold<double>(
    0,
    (sum, p) => sum + (p.sellingPrice * p.quantity),
  );

  double discountRatioOnOriginal;
  try {
    discountRatioOnOriginal = originalSubtotal > 0
        ? (sale.discount / originalSubtotal)
        : 0.0;
  } catch (e) {
    debugPrint('Error calculating discount ratio: $e');
    return;
  }

  // 2) حضّر المتغيرات
  double returnedSubtotal = 0.0;
  double totalProfitReduced = 0.0;
  final List<ReturnedProduct> returnedProducts = [];

  // 3) لف على الأصناف المطلوبة
  for (final entry in quantitiesToReturn.entries) {
    final productName = entry.key;
    final qtyRequested = entry.value;

    if (qtyRequested <= 0) continue;

    final SoldProductModel soldItem = sale.soldProducts
        .firstWhere((sp) => sp.productName == productName);

    if (qtyRequested > soldItem.quantity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot return more than sold for $productName')),
      );
      return; // وقف هنا
    }

    final int qtyToReturn = qtyRequested;

    final double itemSubtotal = soldItem.sellingPrice * qtyToReturn;
    final double itemAllocatedDiscount = itemSubtotal * discountRatioOnOriginal;

    final double itemGrossProfit =
        (soldItem.sellingPrice - soldItem.buyingPrice) * qtyToReturn;

    final double itemProfitReduced = itemGrossProfit - itemAllocatedDiscount;

    try {
      await ref
          .read(productProviderNotifier.notifier)
          .increaseProductQuantity(productName, qtyToReturn);
    } on Exception catch (e) {
      debugPrint('Error increasing product quantity: $e');
      return;
    }

    final prodIndex = productsHive.values.toList().indexWhere(
      (p) => p.productName == productName,
    );
    String productIdStr = '';
    if (prodIndex != -1) {
      final p = productsHive.getAt(prodIndex)!;
      productIdStr = p.id.toString();
    }

    returnedProducts.add(
      ReturnedProduct(
        productId: productIdStr,
        name: productName,
        quantity: qtyToReturn,
        price: soldItem.sellingPrice,
        profitReduced: itemProfitReduced,
      ),
    );

    returnedSubtotal += itemSubtotal;
    totalProfitReduced += itemProfitReduced;
  }

  if (returnedProducts.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nothing to return')),
    );
    return;
  }

  // 4) احسب الخصم المسترجع وقيمة الاسترجاع
  final double discountReturned = returnedSubtotal * discountRatioOnOriginal;
  final double totalRefund = returnedSubtotal - discountReturned;

  // 5) عدل عملية البيع
  final updatedSoldProducts = sale.soldProducts.map((sp) {
    final r = quantitiesToReturn[sp.productName] ?? 0;
    final newQty = sp.quantity - (r > sp.quantity ? sp.quantity : r);
    if (newQty > 0) {
      return SoldProductModel(
        productName: sp.productName,
        sellingPrice: sp.sellingPrice,
        buyingPrice: sp.buyingPrice,
        quantity: newQty,
      );
    } else {
      return null;
    }
  }).whereType<SoldProductModel>().toList();

  // 6) إجمالي جديد
  final double remainingSubtotal =
      originalSubtotal - returnedSubtotal; // قبل الخصم
  final double discountRemaining = sale.discount - discountReturned;
  final double newTotal = remainingSubtotal - discountRemaining;
  final double newChange = sale.paid - newTotal;

  // 7) اكتب في Hive
  final saleIndex = salesBox.values.toList().indexOf(sale);
  if (saleIndex != -1) {
    if (updatedSoldProducts.isEmpty) {
      try {
        await salesBox.deleteAt(saleIndex);
      } on Exception catch (e) {
        debugPrint('Error deleting sale: $e');
      }
    } else {
      final updatedSale = SalesModel(
        discount: discountRemaining,
        soldProducts: updatedSoldProducts,
        paid: sale.paid,
        dateTime: sale.dateTime,
        total: newTotal,
        change: newChange,
        name: sale.name,
      );
      try {
        await salesBox.putAt(saleIndex, updatedSale);
      } on Exception catch (e) {
        debugPrint('Error updating sale: $e');
      }
    }
  }

  // 8) سجل عملية الإرجاع
  final returnTx = ReturnTransaction(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    date: DateTime.now(),
    products: returnedProducts,
    totalRefund: totalRefund,
    totalProfitReduced: totalProfitReduced,
  );
  try {
    await returnsBox.add(returnTx);
  } on Exception catch (e) {
    debugPrint('Error adding return transaction: $e');
  }

  // 9) حدث UI
  ref.read(salesProductProvider.notifier).state =
      salesBox.values.toList().reversed.toList();

  // 10) رسالة نجاح
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Return processed successfully')),
  );
}



}
