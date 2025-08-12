
import 'package:flutter/cupertino.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/reports/logic/helper/pick_date.dart';
import 'package:small_managements/features/reports/ui/widgets/filter_date_range.dart';

class SelectStartDate extends StatelessWidget {
  const SelectStartDate({
    super.key,
    required this.widget,
  });

  final FilterDateRange widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
