import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/settings/logic/setting_provider.dart';
import 'package:small_managements/features/splash/ui/splash_view.dart';
import 'package:small_managements/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('lang') ?? 'en';
  final isDark = prefs.getBool('isDark') ?? false;

  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>(productBox);
  runApp(
    ProviderScope(
      overrides: [
        localizationProvider.overrideWith((ref) => Locale(langCode)),
        themeModeProvider.overrideWith((ref) {
          return isDark ? ThemeMode.dark : ThemeMode.light;
        }),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      locale: ref.watch(localizationProvider),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar'), Locale('en')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.kButtonNavBarColor,
          unselectedItemColor: AppColors.kPrimeryColor,
          selectedItemColor: Colors.white,
          unselectedLabelStyle: TextStyle(color: AppColors.kPrimeryColor),
        ),
        scaffoldBackgroundColor: AppColors.kBackgroundColor,
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'RobotoSlab'),
      ),
      themeMode: ref.watch(themeModeProvider),
      home: SplashView(),
    );
  }
}
