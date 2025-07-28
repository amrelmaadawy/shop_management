
import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';

class AdditionalOptionsBottomSheet extends StatelessWidget {
  const AdditionalOptionsBottomSheet({
    super.key,
    required this.discountController,
  });

  final TextEditingController discountController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'additional options',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
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
            controller: discountController,
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
                backgroundColor:
                    AppColors.kAddProductButtonColor,
              ),
              onPressed: () {},
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
