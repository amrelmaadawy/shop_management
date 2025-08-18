import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/onboarding/UI/onboarding.dart';
import 'package:small_managements/features/products/model/category_model.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/sales/model/sales_model.dart';
import 'package:small_managements/features/sales/model/sold_product_model.dart';
import 'package:small_managements/features/sales/model/todays_total_sold.dart';
import 'package:small_managements/features/settings/logic/setting_provider.dart';
import 'package:small_managements/features/splash/ui/splash_view.dart';
import 'package:small_managements/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('lang') ?? 'en';
  final isDark = prefs.getBool('isDark') ?? false;
  final showHome = prefs.getBool('showHome') ?? false;
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(SalesModelAdapter());
  Hive.registerAdapter(SoldProductModelAdapter());
  Hive.registerAdapter(TodaysTotalSoldAdapter());
  await Hive.openBox<TodaysTotalSold>(totalSoldToday);
  await Hive.openBox<SalesModel>(ksalesBox);
  await Hive.openBox<ProductModel>(productBox);
  await Hive.openBox<CategoryModel>(categoriesBox);
  runApp(
    ProviderScope(
      overrides: [
        localizationProvider.overrideWith((ref) => Locale(langCode)),
        themeModeProvider.overrideWith((ref) {
          return isDark ? ThemeMode.dark : ThemeMode.light;
        }),
      ],
      child: MyApp(showHome),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp(this.showHome, {super.key});
  final bool showHome;
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
      theme: ThemeData.light().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'RobotoSlab',
          bodyColor: Colors.black,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedItemColor: AppColors.kUnselectedItemLightMode,
          selectedItemColor: AppColors.kselectedItemLightMode,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.kButtonNavBarColorDarkMode,
          unselectedItemColor: AppColors.kUnselectedItemDarkMode,
          selectedItemColor: Colors.white,
          unselectedLabelStyle: TextStyle(color: AppColors.kUnselectedItemDarkMode),
        ),
        scaffoldBackgroundColor: AppColors.kBackgroundColor,
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'RobotoSlab'),
      ),
      themeMode: ref.watch(themeModeProvider),
      home: showHome ? SplashView() : Onboarding(),
    );
  }
}
