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
import 'package:small_managements/features/settings/ui/widgets/custom_settings_row.dart';
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
                CustomSettingsRow(
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
                ),
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
                          title: Text('Add Shop Name'),
                          content: CustomTextFormField(
                            controller: shopNameController,
                            keyboardType: TextInputType.text,
                            labelText: 'Shop Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'The shop name cannot be empty';
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
                              child: Text('Save'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CustomSettingsRow(
                    icon: Icon(Icons.store_outlined),
                    text: S.of(context).shopName,
                    widget: Text(shopName ?? 'Shop Name'),
                  ),
                ),
                SizedBox(height: 15),

                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Add phone Number'),
                          content: CustomTextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
                            labelText: 'phone number',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'The phone number cannot be empty';
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
                              child: Text('Save'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CustomSettingsRow(
                    icon: Icon(CupertinoIcons.phone),
                    text: S.of(context).phoneNumber,
                    widget: Text(phoneNumber ?? 'Empty'),
                  ),
                ),
                Spacer(),
                SizedBox(
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
                                Navigator.pop(context);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
