import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/reports/logic/helper/pick_date.dart';
import 'package:small_managements/generated/l10n.dart';

class FilterDateRange extends StatelessWidget {
  const FilterDateRange({
    super.key,
    required this.startDateController,
    required this.endDateController,
  });

  final TextEditingController startDateController;
  final TextEditingController endDateController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).dateRange,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.44,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('From', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        await pickDate(context, startDateController);
                      },
                      child: AbsorbPointer(
                        child: CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter The Start Date';
                            } else {
                              return null;
                            }
                          },
                          controller: startDateController,
                          keyboardType: TextInputType.text,
                          labelText: 'Select Date',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.44,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('To', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        await pickDate(context, endDateController);
                      },
                      child: AbsorbPointer(
                        child: CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter The End Date';
                            } else {
                              return null;
                            }
                          },
                          controller: endDateController,
                          keyboardType: TextInputType.text,
                          labelText: 'Select Date',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                  'Reset',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kAddProductButtonColor,
                ),
                onPressed: () {},
                child: Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
