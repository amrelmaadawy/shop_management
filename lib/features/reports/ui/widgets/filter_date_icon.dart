
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/features/reports/ui/widgets/filter_date_range.dart';

class FilterDateIcon extends StatelessWidget {
  const FilterDateIcon({
    super.key,
    required this.ref,
    required this.startDateController,
    required this.endDateController,
  });

  final WidgetRef ref;
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 40,
      child: IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return FilterDateRange(
                ref: ref,
                startDateController: startDateController,
                endDateController: endDateController,
              );
            },
          );
        },
        icon: Icon(Icons.calendar_month_outlined),
      ),
    );
  }
}
