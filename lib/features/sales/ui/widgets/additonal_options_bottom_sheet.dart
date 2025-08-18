import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/sales/logic/provider/select_product_provider.dart';

class AdditionalOptionsBottomSheet extends ConsumerStatefulWidget {
  const AdditionalOptionsBottomSheet({super.key});

  @override
  ConsumerState<AdditionalOptionsBottomSheet> createState() =>
      _AdditionalOptionsBottomSheetState();
}

class _AdditionalOptionsBottomSheetState
    extends ConsumerState<AdditionalOptionsBottomSheet> {
  TextEditingController discountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController paidController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) { 
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Confirm sale',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Form(
              key: key,
              child: CustomTextFormField(
                controller: paidController,
                keyboardType: TextInputType.number,
                labelText: 'paid',
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'please Enter the paid amount';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              controller: discountController,
              keyboardType: TextInputType.text,
              labelText: 'discount(optional)',
              validator: (v) {
                return null;
              },
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              labelText: 'client Name(optional)',
              validator: (v) {
                return null;
              },
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kBlueElevatedButtonDarkMode,
                ),
                onPressed: () {
                  if (key.currentState!.validate()) {
                  
                    ref
                        .read(selectProductProvider.notifier)
                        .confirmSale(
                          paid: double.parse(paidController.text),
                          name: nameController.text,
                          discount:
                              double.tryParse(discountController.text) ?? 0,
                          ref: ref, context: context,
                        );
                  
                  }
                },
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
      ),
    );
  }
}
