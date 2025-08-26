
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:restart_app/restart_app.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/generated/l10n.dart';

class ResetApplicationButton extends StatelessWidget {
  const ResetApplicationButton({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark
              ? AppColors.kBlueElevatedButtonDarkMode
              : AppColors.kBlueElevatedButtonLightMode,
        ),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(S.of(context).areYouSureYouWantToResetTheApp),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    await Hive.deleteBoxFromDisk(totalSoldToday);
                    await Hive.deleteBoxFromDisk(ksalesBox);
                    await Hive.deleteBoxFromDisk(productBox);
                    await Hive.deleteBoxFromDisk(categoriesBox);
                    await Hive.deleteBoxFromDisk(kReturnsBox);
                      Restart.restartApp(); 
                  },
                  child: Text(S.of(context).yes),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).no),
                ),
              ],
            ),
          );
        },
        child: Text(
          S.of(context).resetApplication,
          style: TextStyle(
            color: isDark
                ? AppColors.kBlackTextLightMode
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
