import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/products/logic/providers/product_providers.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/sales/logic/provider/select_product_provider.dart';
import 'package:small_managements/generated/l10n.dart';

class MakeSale extends ConsumerStatefulWidget {
  const MakeSale({super.key});

  @override
  ConsumerState<MakeSale> createState() => _MakeSaleState();
}

class _MakeSaleState extends ConsumerState<MakeSale> {
  TextEditingController selectProductController = TextEditingController();

  TextEditingController quantitySoldController = TextEditingController();

  TextEditingController discountController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    selectProductController.dispose();
    quantitySoldController.dispose();
    discountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      S.of(context).makeSale,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Autocomplete<ProductModel>(
                  displayStringForOption: (ProductModel option) =>
                      option.productName,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return ref
                        .read(productProviderNotifier)
                        .where(
                          (product) => product.productName
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()),
                        );
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onFieldSubmitted) {
                        return CustomTextFormField(
                          focusNode: focusNode,
                          controller: controller,
                          keyboardType: TextInputType.text,
                          labelText: 'search for product',
                          validator: (v) {
                            return null;
                          },
                        );
                      },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 8,
                        child: ListView(
                          shrinkWrap: true,
                          children: options.map((product) {
                            return ListTile(
                              title: Text(product.productName),
                              trailing: Text("${product.price} \$"),
                              onTap: () => onSelected(product),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  onSelected: (ProductModel selectedProduct) {
                    ref
                        .read(selectProductProvider.notifier)
                        .addProduct(selectedProduct);
                  },
                ),
                SizedBox(height: 15),

                // Expanded هنا بس بنسكرول المنتجات
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('product A'),
                                    SizedBox(height: 5),
                                    Text('individual Price 5 LE'),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.kIncreaseContainerColor,
                                  ),
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.kIncreaseContainerColor,
                                  ),
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          childCount: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),
                Text(
                  'Total Price = 1200 LE',
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
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                      } else {
                        autoValidateMode = AutovalidateMode.always;
                      }
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'additional options',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                CustomTextFormField(
                                  controller: discountController,
                                  keyboardType: TextInputType.number,
                                  labelText: 'discount',
                                  validator: (v) {
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                CustomTextFormField(
                                  controller: discountController,
                                  keyboardType: TextInputType.number,
                                  labelText: 'client Name',
                                  validator: (v) {
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.kAddProductButtonColor,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Apply discount',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
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
