import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:small_managements/core/hive_boxes.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/products/model/product_model.dart';
import 'package:small_managements/features/splash/ui/splash_view.dart';
import 'package:small_managements/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<ProductModel>(productBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.kBackgroundColor,
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'RobotoSlab'),
      ),
      home: SplashView(),
    );
  }
}
