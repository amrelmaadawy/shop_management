import 'package:flutter/material.dart';

class CustomTotalsRow extends StatelessWidget {
  const CustomTotalsRow({super.key, required this.totals, required this.label});

  final String totals;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label ', style: TextStyle(fontSize: 16)),
        Spacer(),
        Text(
          totals,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
