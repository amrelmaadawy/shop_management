   import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> pickDate(
  BuildContext context,
  TextEditingController dateController,
) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    // ✅ صيغة سليمة يمكن استخدامها مع DateTime.parse
    final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    dateController.text = formattedDate;
  }
}