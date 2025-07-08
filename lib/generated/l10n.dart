// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome To Shope Manager`
  String get splashWelcome {
    return Intl.message(
      'Welcome To Shope Manager',
      name: 'splashWelcome',
      desc: 'welcome message on splash screen',
      args: [],
    );
  }

  /// `Manage your products, track sales, and generate reports with ease.`
  String get splashTitel {
    return Intl.message(
      'Manage your products, track sales, and generate reports with ease.',
      name: 'splashTitel',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get homeAppBar {
    return Intl.message('Overview', name: 'homeAppBar', desc: '', args: []);
  }

  /// `Total Sales Today`
  String get TotalSales {
    return Intl.message(
      'Total Sales Today',
      name: 'TotalSales',
      desc: '',
      args: [],
    );
  }

  /// `Compared to $1,100 yesterday`
  String get compareTo {
    return Intl.message(
      'Compared to \$1,100 yesterday',
      name: 'compareTo',
      desc: '',
      args: [],
    );
  }

  /// `Total Products in Stock`
  String get Totalproduct {
    return Intl.message(
      'Total Products in Stock',
      name: 'Totalproduct',
      desc: '',
      args: [],
    );
  }

  /// `Including 5 new items`
  String get itemsInclude {
    return Intl.message(
      'Including 5 new items',
      name: 'itemsInclude',
      desc: '',
      args: [],
    );
  }

  /// `Sales Summary`
  String get salesSummary {
    return Intl.message(
      'Sales Summary',
      name: 'salesSummary',
      desc: '',
      args: [],
    );
  }

  /// `This Week`
  String get thisWeek {
    return Intl.message('This Week', name: 'thisWeek', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
