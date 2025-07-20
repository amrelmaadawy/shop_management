
import 'package:flutter/material.dart';
import 'package:small_managements/generated/l10n.dart';

class CustomProductAppBar extends StatelessWidget {
  const CustomProductAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        Text(
          S.of(context).addProduct,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
