import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/settings/ui/widgets/custom_settings_row.dart';
import 'package:small_managements/generated/l10n.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
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
                  value: false,
                  onChanged: (value) {},
                  activeColor: AppColors.kPrimeryColor,
                ),
              ),
              SizedBox(height: 15),
              CustomSettingsRow(
                icon: Icon(Icons.language_outlined),
                text: S.of(context).language,
                widget: Text('English'),
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
