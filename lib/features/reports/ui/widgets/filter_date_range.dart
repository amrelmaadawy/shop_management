import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/reports/ui/widgets/date_filter_buttons.dart';
import 'package:small_managements/features/reports/ui/widgets/select_end_date.dart';
import 'package:small_managements/features/reports/ui/widgets/select_start_date.dart';
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
                SelectStartDate(widget: widget),
                SelectEndDate(widget: widget),
              ],
            ),
          ),
          SizedBox(height: 15),
          DateFilterButtons(widget: widget, formKey: formKey),
        ],
      ),
    );
  }
}
