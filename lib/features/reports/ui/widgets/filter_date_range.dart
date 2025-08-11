import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/reports/logic/helper/get_total_sales.dart';
import 'package:small_managements/features/reports/logic/helper/pick_date.dart';
import 'package:small_managements/features/reports/ui/customized_report.dart';
import 'package:small_managements/generated/l10n.dart';

class FilterDateRange extends StatefulWidget {
  const FilterDateRange({
    super.key,
    required this.startDateController,
    required this.endDateController,
    required this.ref,
  });

  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final WidgetRef ref;

  @override
  State<FilterDateRange> createState() => _FilterDateRangeState();
}

class _FilterDateRangeState extends State<FilterDateRange> {
  final GlobalKey<FormState> formKey = GlobalKey();

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
          Form(
            key: formKey,
            child: Row(
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
                          await pickDate(context, widget.startDateController);
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
                            controller: widget.startDateController,
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
                          await pickDate(context, widget.endDateController);
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
                            controller: widget.endDateController,
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
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kIncreaseContainerColor,
                ),
                onPressed: () {
                  widget.startDateController.clear();
                  widget.endDateController.clear();
                },
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final startDate = DateTime.parse(
                      widget.startDateController.text,
                    );
                    final endDate = DateTime.parse(
                      widget.endDateController.text,
                    );
                    final totalSales = getTotalSalesInRange(
                      widget.ref,
                      startDate,
                      endDate,
                    );
                    final totalProductsSold = getTotalProductSoldInRange(
                      widget.ref,
                      startDate,
                      endDate,
                    );
                    final totalProfit = getTotalProfitInRange(
                      widget.ref,
                      startDate,
                      endDate,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomizedReport(
                          totalSales: totalSales,
                          totalProductSold: totalProductsSold,
                          totalProfit: totalProfit,
                        ),
                      ),
                    );
                    widget.startDateController.clear();
                    widget.endDateController.clear();
                  }
                },
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
