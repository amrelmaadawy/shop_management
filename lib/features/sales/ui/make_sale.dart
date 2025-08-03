import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/sales/logic/provider/select_product_provider.dart';

import 'package:small_managements/features/sales/ui/widgets/additonal_options_bottom_sheet.dart';
import 'package:small_managements/features/sales/ui/widgets/list_of_selling_products.dart';
import 'package:small_managements/features/sales/ui/widgets/make_sale_app_bar.dart';
import 'package:small_managements/features/sales/ui/widgets/search_for_product_form_field.dart';
import 'package:small_managements/generated/l10n.dart';

class MakeSale extends ConsumerStatefulWidget {
  const MakeSale({super.key});

  @override
  ConsumerState<MakeSale> createState() => _MakeSaleState();
}

class _MakeSaleState extends ConsumerState<MakeSale> {
  TextEditingController selectProductController = TextEditingController();

  TextEditingController quantitySoldController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    selectProductController.dispose();
    quantitySoldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedProducts = ref.watch(selectProductProvider);
    final totalPrice = selectedProducts.fold<double>(
      0,
      (sum, item) => sum + (item.totalPrice),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MakeSaleAppBar(),
                SizedBox(height: 15),
                SearchForProductFormField(ref: ref),
                SizedBox(height: 15),

                Expanded(
                  child: CustomScrollView(slivers: [ListOfSellingProducts()]),
                ),

                SizedBox(height: 15),
                Text(
                  'Total Price = $totalPrice LE',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kAddProductButtonColor,
                    ),
                    onPressed: () {
                      final selectedProducts = ref.watch(selectProductProvider);
                      if (selectedProducts.isNotEmpty) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return AdditionalOptionsBottomSheet();
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please select at least one product',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: const Color.fromARGB(255, 153, 11, 1),
                          ),
                        );
                      }
                    },
                    child: Text(
                      S.of(context).confirmeSale,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
