import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/ui/add_product.dart';
import 'package:small_managements/features/products/ui/widgets/custom_product_container.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
import 'package:small_managements/features/products/ui/widgets/product_item.dart';
import 'package:small_managements/generated/l10n.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kAddProductButtonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            
            children: [
              Text(
                S.of(context).products,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                validator: (value ) {
                      if(value!.isEmpty)
                      {
                        return'Please Enter The Poduct Name';
                      }else{return null;}
                      },
                prefixIcon: Icon(Icons.search),
                controller: searchController,
                keyboardType: TextInputType.text,
                labelText: S.of(context).searchProduct,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomProductContainer(text: S.of(context).category),
                  CustomProductContainer(text: S.of(context).price),
                  CustomProductContainer(text: S.of(context).stock),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.586,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ProductItem();
                  },
                  itemCount: 10,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
