import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/sales/logic/provider/sales_provider.dart';
import 'package:small_managements/features/sales/model/sales_model.dart';
import 'package:small_managements/features/sales/model/selected_prodcut_model.dart';
import 'package:small_managements/features/sales/model/sold_product_model.dart';
import 'package:small_managements/features/sales/model/todays_total_sold.dart';

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

    // تجهيز قائمة المنتجات المباعة
    final soldProducts = state.map((item) {
      return SoldProductModel(
        sellingPrice: double.parse(item.product.sellingPrice),
        productName: item.product.productName,
        buyingPrice: double.parse(item.product.buyingPrice),
        quantity: item.quantity,
      );
    }).toList();

    // إجمالي المبيعات قبل الخصم
    final totalBeforeDiscount = soldProducts.fold<double>(
      0,
      (sum, item) => sum + (item.sellingPrice * item.quantity),
    );

    // إجمالي المبيعات بعد الخصم
    final totalAfterDiscount = totalBeforeDiscount - discount;

    // تحقق من المبلغ المدفوع
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

    // حساب الباقي
    final change = paid - totalAfterDiscount;

    // إجمالي الربح قبل الخصم
    final totalProfitBeforeDiscount = soldProducts.fold<double>(
      0,
      (sum, item) =>
          sum + ((item.sellingPrice - item.buyingPrice) * item.quantity),
    );

    // توزيع الخصم على الربح بشكل نسبي
    double totalProfitAfterDiscount = totalProfitBeforeDiscount;
    if (discount > 0 && totalBeforeDiscount > 0) {
      final discountRatio = discount / totalBeforeDiscount; // نسبة الخصم
      totalProfitAfterDiscount =
          totalProfitBeforeDiscount -
          (totalProfitBeforeDiscount * discountRatio);
    }

    // إنشاء السيل
    final sale = SalesModel(
      soldProducts: soldProducts,
      paid: paid,
      dateTime: DateTime.now(),
      total: totalAfterDiscount,
      change: change,
      name: name ?? '',
      discount: discount,
    );

    // تحديث الإحصائيات اليومية
    totalProductSoldToday = state.fold(0, (sum, item) => sum + item.quantity);
    totalSalesToday = totalAfterDiscount.toInt();
    totalProfitToday = totalProfitAfterDiscount.toInt();

    final todaysTotalSold = TodaysTotalSold(
      totalProductSoldToday: totalProductSoldToday,
      totalSalesToday: totalSalesToday,
      totalProfitToday: totalProfitToday,
    );

    // حفظ البيانات
    await todaySoldBox.add(todaysTotalSold);
    await box.add(sale);

    // تقليل الكميات من المخزون
    for (final item in soldProducts) {
      await ref
          .read(productProviderNotifier.notifier)
          .decreaseProductQuantity(item.productName, item.quantity);
    }

    // تحديث القائمة في الـ UI
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
}
