

import 'package:flutter/material.dart';
import 'package:small_managements/generated/l10n.dart';

class MakeSaleAppBar extends StatelessWidget {
  const MakeSaleAppBar({
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
          S.of(context).makeSale,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
