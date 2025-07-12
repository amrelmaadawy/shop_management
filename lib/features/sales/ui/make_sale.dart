import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/ui/widgets/custom_text_form_field.dart';
import 'package:small_managements/generated/l10n.dart';

class MakeSale extends StatelessWidget {
  const MakeSale({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['cups', 'dishies'];
    TextEditingController selectProductController = TextEditingController();
    TextEditingController quantitySoldController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  await showMenu<String>(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 100, 100),
                    items: categories
                        .map((e) => PopupMenuItem(value: e, child: Text(e)))
                        .toList(),
                  );
                },
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    controller: selectProductController,
                    keyboardType: TextInputType.number,
                    labelText: S.of(context).selectProduct,
                  ),
                ),
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                controller: quantitySoldController,
                keyboardType: TextInputType.text,
                labelText: S.of(context).quantitySold,
              ),
              SizedBox(height: 15),

              CustomTextFormField(
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
                  onPressed: () {},
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
    );
  }
}
