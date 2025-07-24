import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/logic/notifier/product_notifier.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/products/ui/widgets/add_image_picker.dart';
import 'package:small_managements/features/products/ui/widgets/add_product_text_form_feilds.dart';
import 'package:small_managements/features/products/ui/widgets/cancel_product_buttom.dart';
import 'package:small_managements/features/products/ui/widgets/custom_product_app_bar.dart';
import 'package:small_managements/generated/l10n.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key, this.productModel, this.index});
  final ProductModel? productModel;
  final int? index;
  @override
  ConsumerState<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  File? selectedImage;
  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    categoryController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    if (widget.productModel != null) {
      productNameController.text = widget.productModel!.productName;
      priceController.text = widget.productModel!.price;
      quantityController.text = widget.productModel!.quantity;
      categoryController.text = widget.productModel!.category;
    }
    Future.microtask(() {
      ref.read(pickImageProvider.notifier).state = widget.productModel?.image;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: form,
              autovalidateMode: autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomProductAppBar(),
                  SizedBox(height: 10),
                  AddProductTextFormFields(
                    productNameController: productNameController,
                    priceController: priceController,
                    quantityController: quantityController,
                    ref: ref,
                    categoryController: categoryController,
                  ),

                  SizedBox(height: 20),
                  Text(
                    S.of(context).productImage,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  AddImagePicker(),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CancelProductButton(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kAddProductButtonColor,
                        ),
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            if (widget.productModel != null) {
                              final imagePath = ref.watch(pickImageProvider);

                              final newProduct = ProductModel(
                                category: categoryController.text,
                                price: priceController.text,
                                productName: productNameController.text,
                                quantity: quantityController.text,
                                image: imagePath,
                                id: 0,
                              );
                              ref
                                  .read(productProviderNotifier.notifier)
                                  .updatePrdouct(newProduct, widget.index!);
                              Navigator.pop(context);
                            } else {
                              final imagePath = ref.watch(pickImageProvider);
                              form.currentState!.save();
                              final product = ProductModel(
                                category: categoryController.text,
                                price: priceController.text,
                                productName: productNameController.text,
                                quantity: quantityController.text,
                                image: imagePath,
                                id: 0,
                              );
                              ref
                                  .read(productProviderNotifier.notifier)
                                  .addProduct(product);
                              categoryController.clear();
                              productNameController.clear();
                              priceController.clear();
                              quantityController.clear();
                              Navigator.pop(context);
                            }
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                          }
                        },
                        child: Text(
                          S.of(context).save,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
