import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/logic/product_notifier.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/products/ui/widgets/add_image_picker.dart';
import 'package:small_managements/features/products/ui/widgets/cancel_product_buttom.dart';
import 'package:small_managements/features/products/ui/widgets/custom_product_app_bar.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
import 'package:small_managements/generated/l10n.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});

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
  List<String> categories = ['cups', 'dishies'];
  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    categoryController.dispose();

    super.dispose();
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

                  CustomTextFormField(
                    controller: productNameController,
                    keyboardType: TextInputType.text,
                    labelText: S.of(context).productName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter The Poduct Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  CustomTextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    labelText: S.of(context).price,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter The Price of the Product';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  CustomTextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    labelText: S.of(context).quantity,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter The quantity';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTapDown: (details) async {
                      final selected = await showMenu<String>(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          details.globalPosition.dx,
                          details.globalPosition.dy,
                          details.globalPosition.dx + 1,
                          details.globalPosition.dy + 1,
                        ),
                        items: categories
                            .map((e) => PopupMenuItem(value: e, child: Text(e)))
                            .toList(),
                      );
                      if (selected != null) {
                        ref.read(chooseCategoryProvider.notifier).state =
                            selected;
                        final category = ref.watch(chooseCategoryProvider);
                        categoryController.text = category!;
                      }
                    },
                    child: AbsorbPointer(
                      child: CustomTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter The Category ';
                          } else {
                            return null;
                          }
                        },
                        controller: categoryController,
                        keyboardType: TextInputType.text,
                        labelText: S.of(context).category,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    S.of(context).productImage,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  AddImagePicker(ref: ref),
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
                            final imagePath = ref.watch(pickImageProvider);
                            form.currentState!.save();
                            final product = ProductModel(
                              category: categoryController.text,
                              price: priceController.text,
                              productName: productNameController.text,
                              quantity: quantityController.text,
                              image: imagePath ?? '',
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

