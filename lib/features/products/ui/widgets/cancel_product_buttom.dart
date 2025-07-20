
import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/generated/l10n.dart';

class CancelProductButton extends StatelessWidget {
  const CancelProductButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kIncreaseContainerColor,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        S.of(context).cancel,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
