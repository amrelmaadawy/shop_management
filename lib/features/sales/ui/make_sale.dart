import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
import 'package:small_managements/generated/l10n.dart';

class MakeSale extends StatefulWidget {
  const MakeSale({super.key});

  @override
  State<MakeSale> createState() => _MakeSaleState();
}

class _MakeSaleState extends State<MakeSale> {
  List<String> categories = ['cups', 'dishies'];

  TextEditingController selectProductController = TextEditingController();

  TextEditingController quantitySoldController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  void dispose() {
    selectProductController.dispose();
    quantitySoldController.dispose();
    priceController.dispose();
    
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
                GestureDetector(
                  onTap: () async {
                    final selected = await showMenu<String>(
                      context: context,
                      position: RelativeRect.fromLTRB(100, 100, 100, 100),
                      items: categories
                          .map((e) => PopupMenuItem(value: e, child: Text(e)))
                          .toList(),
                    );
                    setState(() {
                      if (selected != null) {
                        selectProductController.text = selected;
                      }
                    });
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter The Poduct';
                        } else {
                          return null;
                        }
                      },
                      controller: selectProductController,
                      keyboardType: TextInputType.number,
                      labelText: S.of(context).selectProduct,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Sold Quantity';
                    } else {
                      return null;
                    }
                  },
                  controller: quantitySoldController,
                  keyboardType: TextInputType.text,
                  labelText: S.of(context).quantitySold,
                ),
                SizedBox(height: 15),

                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter The Price';
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: Icon(Icons.leaderboard),
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  labelText: S.of(context).price,
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
