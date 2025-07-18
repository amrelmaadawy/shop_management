import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/settings/logic/setting_provider.dart';
import 'package:small_managements/features/settings/ui/widgets/custom_settings_row.dart';
import 'package:small_managements/generated/l10n.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localizationProvider);
  
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  S.of(context).settings,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15),
              Text(
                S.of(context).appPrefrance,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              CustomSettingsRow(
                icon: Icon(CupertinoIcons.moon),
                text: S.of(context).darkMode,
                widget: Switch(
                  value: ref.watch(themeModeProvider) == ThemeMode.dark,
                  onChanged: (isDark) async {
                    
                    ref.read(themeModeProvider.notifier).state = isDark
                        ? ThemeMode.dark
                        : ThemeMode.light;
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('isDark', isDark);
                  },
                  activeColor: AppColors.kPrimeryColor,
                ),
              ),
              SizedBox(height: 15),
              CustomSettingsRow(
                icon: Icon(Icons.language_outlined),
                text: S.of(context).language,
                widget: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.kIncreaseContainerColor,
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
                          // غيّر اللغة في Riverpod
                          ref.read(localizationProvider.notifier).state =
                              selected;

                          // (اختياري) خزّن اللغة في SharedPreferences
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('lang', selected.languageCode);
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                S.of(context).businessInfo,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),

              CustomSettingsRow(
                icon: Icon(Icons.store_outlined),
                text: S.of(context).shopName,
                widget: Text('My shop'),
              ),
              SizedBox(height: 15),

              CustomSettingsRow(
                icon: Icon(CupertinoIcons.phone),
                text: S.of(context).phoneNumber,
                widget: Text('01231231234'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
