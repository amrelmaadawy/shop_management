import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
import 'package:small_managements/generated/l10n.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  List<String> categories = ['cups', 'dishies'];
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      Text(
                        S.of(context).addProduct,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
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
                        setState(() {
                          categoryController.text = selected;
                        });
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: DottedBorder(
                      options: RectDottedBorderOptions(
                        color: AppColors.kIncreaseContainerColor,
                        dashPattern: [10, 5],
                        strokeWidth: 2,
                        padding: EdgeInsets.all(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            S.of(context).addImage,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(S.of(context).tapToAdd),
                          SizedBox(height: 24),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.kIncreaseContainerColor,
                            ),
                            onPressed: () {},
                            child: Text(
                              S.of(context).addImage,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kIncreaseContainerColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          S.of(context).cancel,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kAddProductButtonColor,
                        ),
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            form.currentState!.save();
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
