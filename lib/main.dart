import 'package:flutter/material.dart';
import 'package:small_managements/features/splash/ui/splash_view.dart';
import 'package:small_managements/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
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
      theme: ThemeData(fontFamily: 'RobotoSlab'),
      themeMode: ThemeMode.dark,
      home: SplashView(),
    );
  }
}
