
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/settings/logic/setting_provider.dart';
import 'package:small_managements/features/settings/ui/widgets/custom_settings_row.dart';
import 'package:small_managements/generated/l10n.dart';

class ChangeLanguageRow extends StatelessWidget {
  const ChangeLanguageRow({
    super.key,
    required this.isDark,
    required this.locale,
    required this.ref,
  });

  final bool isDark;
  final Locale locale;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return CustomSettingsRow(
      icon: Icon(Icons.language_outlined),
      text: S.of(context).language,
      widget: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.kGreyElevatedButtonDarkMode
              : AppColors.kGreyElevatedButtonLightMode,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: DropdownButton<Locale>(
            value: locale,
            items: const [
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: Locale('ar'),
                child: Text('العربية'),
              ),
            ],
            onChanged: (Locale? selected) async {
              if (selected != null) {
                ref.read(localizationProvider.notifier).state =
                    selected;
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString(
                  'lang',
                  selected.languageCode,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
