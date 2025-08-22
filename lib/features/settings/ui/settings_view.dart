// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/core/utils/custom_text_form_field.dart';
import 'package:small_managements/features/settings/logic/setting_provider.dart';
import 'package:small_managements/features/settings/ui/widgets/change_language_row.dart';
import 'package:small_managements/features/settings/ui/widgets/custom_settings_row.dart';
import 'package:small_managements/features/settings/ui/widgets/reset_application_button.dart';
import 'package:small_managements/generated/l10n.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  String? shopName;
  String? phoneNumber;
  @override
  void dispose() {
    shopNameController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    getShopName();
    super.initState();
  }

  Future<void> getShopName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      shopName = prefs.getString('shop name');
      phoneNumber = prefs.getString('number');
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localizationProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
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
                    activeColor: AppColors.kUnselectedItemDarkMode,
                  ),
                ),
                SizedBox(height: 15),
                ChangeLanguageRow(isDark: isDark, locale: locale, ref: ref),
                SizedBox(height: 15),
                Text(
                  S.of(context).businessInfo,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),

                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(S.of(context).addShopName),
                          content: CustomTextFormField(
                            controller: shopNameController,
                            keyboardType: TextInputType.text,
                            labelText:S.of(context).shopName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).theShopNameCannotBeEmpty;
                              }
                              return null;
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    prefs.setString(
                                      'shop name',
                                      shopNameController.text,
                                    );
                                    shopName = prefs.getString('shop name');
                                  });
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(S.of(context).save),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(S.of(context).cancel),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CustomSettingsRow(
                    icon: Icon(Icons.store_outlined),
                    text: S.of(context).shopName,
                    widget: Text(shopName ?? S.of(context).shopName),
                  ),
                ),
                SizedBox(height: 15),

                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(S.of(context).addPhoneNumber),
                          content: CustomTextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
                            labelText: S.of(context).phoneNumber,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).thePhoneNumberCannotBeEmpty;
                              }
                              return null;
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    prefs.setString(
                                      'number',
                                      phoneNumberController.text,
                                    );
                                    phoneNumber = prefs.getString('number');
                                  });
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(S.of(context).save),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(S.of(context).cancel),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CustomSettingsRow(
                    icon: Icon(CupertinoIcons.phone),
                    text: S.of(context).phoneNumber,
                    widget: Text(phoneNumber ?? S.of(context).empty),
                  ),
                ),
                Spacer(),
                ResetApplicationButton(isDark: isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
