import 'package:flutter/material.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
import 'package:small_managements/generated/l10n.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).products,
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CustomTextFormField(
                prefixIcon: Icon(Icons.search),
                controller: searchController,
                keyboardType: TextInputType.text,
                labelText: S.of(context).searchProduct,
              ),
              Row(children: [
                
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
