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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'additional options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            controller: nameController,
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
                backgroundColor: AppColors.kAddProductButtonColor,
              ),
              onPressed: () {
                ref
                    .read(selectProductProvider.notifier)
                    .confirmSale(paid: double.parse(discountController.text), name: nameController.text, ref: ref);
                Navigator.pop(context);
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
    );
  }
}
