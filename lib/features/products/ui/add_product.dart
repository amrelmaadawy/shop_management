import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
import 'package:small_managements/generated/l10n.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    List<String> categories = ['cups', 'dishies'];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
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
                ),
                SizedBox(height: 15),
                CustomTextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  labelText: S.of(context).price,
                ),
                SizedBox(height: 15),
                CustomTextFormField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  labelText: S.of(context).quantity,
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    await showMenu<String>(
                      context: context,
                      position: RelativeRect.fromLTRB(100, 300, 100, 100),
                      items: categories
                          .map((e) => PopupMenuItem(value: e, child: Text(e)))
                          .toList(),
                    );
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: categoryController,
                      keyboardType: TextInputType.number,
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
                      strokeWidth: 2 ,
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
                            backgroundColor: AppColors.kIncreaseContainerColor,
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
                      onPressed: () {},
                      child: Text(
                        S.of(context).cancel,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kAddProductButtonColor,
                      ),
                      onPressed: () {},
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
    );
  }
}
