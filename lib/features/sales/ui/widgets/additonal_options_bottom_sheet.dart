import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/sales/logic/provider/select_product_provider.dart';
import 'package:small_managements/generated/l10n.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              S.of(context).confirmSale,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Form(
              key: key,
              child: CustomTextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                controller: paidController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                labelText: S.of(context).paid,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return S.of(context).pleaseEnterThePaidAmount;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
              controller: discountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              labelText:
                  '${S.of(context).discount} (${S.of(context).optional})',
              validator: (v) {
                return null;
              },
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              labelText:
                  '${S.of(context).clientName} (${S.of(context).optional})',
              validator: (v) {
                return null;
              },
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? AppColors.kBlueElevatedButtonDarkMode
                      : AppColors.kBlueElevatedButtonLightMode,
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
                          ref: ref,
                          context: context,
                        );
                  }
                },
                child: Text(
                  S.of(context).applyDiscount,
                  style: TextStyle(
                    color: isDark ? Colors.black : Colors.white,
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
