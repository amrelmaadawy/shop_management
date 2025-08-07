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
  String get TotalSalesToday {
    return Intl.message(
      'Total Sales Today',
      name: 'TotalSalesToday',
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

  /// `Add Product`
  String get addProduct {
    return Intl.message('Add Product', name: 'addProduct', desc: '', args: []);
  }

  /// `Make Sale`
  String get makeSale {
    return Intl.message('Make Sale', name: 'makeSale', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Sales`
  String get sales {
    return Intl.message('Sales', name: 'sales', desc: '', args: []);
  }

  /// `Insights`
  String get reports {
    return Intl.message('Insights', name: 'reports', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Search Product`
  String get searchProduct {
    return Intl.message(
      'Search Product',
      name: 'searchProduct',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Buying Price`
  String get buyingPrice {
    return Intl.message(
      'Buying Price',
      name: 'buyingPrice',
      desc: '',
      args: [],
    );
  }

  /// `Selling Price`
  String get sellingPrice {
    return Intl.message(
      'Selling Price',
      name: 'sellingPrice',
      desc: '',
      args: [],
    );
  }

  /// `Stock`
  String get stock {
    return Intl.message('Stock', name: 'stock', desc: '', args: []);
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Product Image`
  String get productImage {
    return Intl.message(
      'Product Image',
      name: 'productImage',
      desc: '',
      args: [],
    );
  }

  /// `Add Image`
  String get addImage {
    return Intl.message('Add Image', name: 'addImage', desc: '', args: []);
  }

  /// `Tap to add an image from your gallery or take a new one.`
  String get tapToAdd {
    return Intl.message(
      'Tap to add an image from your gallery or take a new one.',
      name: 'tapToAdd',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Total Sales This Month`
  String get totalSalesThisMonth {
    return Intl.message(
      'Total Sales This Month',
      name: 'totalSalesThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Total Product Sold `
  String get totalProductSold {
    return Intl.message(
      'Total Product Sold ',
      name: 'totalProductSold',
      desc: '',
      args: [],
    );
  }

  /// `Total Profit Today`
  String get totalProfitToday {
    return Intl.message(
      'Total Profit Today',
      name: 'totalProfitToday',
      desc: '',
      args: [],
    );
  }

  /// `Recent Transactions`
  String get recentTransactions {
    return Intl.message(
      'Recent Transactions',
      name: 'recentTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message('Product', name: 'product', desc: '', args: []);
  }

  /// `Confirm Sale`
  String get confirmeSale {
    return Intl.message(
      'Confirm Sale',
      name: 'confirmeSale',
      desc: '',
      args: [],
    );
  }

  /// `Quantity Sold`
  String get quantitySold {
    return Intl.message(
      'Quantity Sold',
      name: 'quantitySold',
      desc: '',
      args: [],
    );
  }

  /// `Select Product`
  String get selectProduct {
    return Intl.message(
      'Select Product',
      name: 'selectProduct',
      desc: '',
      args: [],
    );
  }

  /// `Date Filter`
  String get dateRange {
    return Intl.message('Date Filter', name: 'dateRange', desc: '', args: []);
  }

  /// `Total Sales`
  String get totalSales {
    return Intl.message('Total Sales', name: 'totalSales', desc: '', args: []);
  }

  /// `Orders`
  String get orders {
    return Intl.message('Orders', name: 'orders', desc: '', args: []);
  }

  /// `Top Selling Items`
  String get topSellingItems {
    return Intl.message(
      'Top Selling Items',
      name: 'topSellingItems',
      desc: '',
      args: [],
    );
  }

  /// `Sold`
  String get sold {
    return Intl.message('Sold', name: 'sold', desc: '', args: []);
  }

  /// `App Prefrances`
  String get appPrefrance {
    return Intl.message(
      'App Prefrances',
      name: 'appPrefrance',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Business Info`
  String get businessInfo {
    return Intl.message(
      'Business Info',
      name: 'businessInfo',
      desc: '',
      args: [],
    );
  }

  /// `Shop Name`
  String get shopName {
    return Intl.message('Shop Name', name: 'shopName', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please Add Product Name`
  String get pleaseAddProductName {
    return Intl.message(
      'Please Add Product Name',
      name: 'pleaseAddProductName',
      desc: '',
      args: [],
    );
  }

  /// `Image Selected`
  String get imageSelected {
    return Intl.message(
      'Image Selected',
      name: 'imageSelected',
      desc: '',
      args: [],
    );
  }

  /// `Delete Image`
  String get deleteImage {
    return Intl.message(
      'Delete Image',
      name: 'deleteImage',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter The Price`
  String get pleaseAddThePrice {
    return Intl.message(
      'Please Enter The Price',
      name: 'pleaseAddThePrice',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter The Quantity`
  String get pleaseAddTheQuantity {
    return Intl.message(
      'Please Enter The Quantity',
      name: 'pleaseAddTheQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter The Category`
  String get pleaseAddTheCategory {
    return Intl.message(
      'Please Enter The Category',
      name: 'pleaseAddTheCategory',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `There is no products`
  String get thereIsNoProducts {
    return Intl.message(
      'There is no products',
      name: 'thereIsNoProducts',
      desc: '',
      args: [],
    );
  }

  /// `in Storck`
  String get inStock {
    return Intl.message('in Storck', name: 'inStock', desc: '', args: []);
  }

  /// `Are You Sure You Want To delete`
  String get areYouSureYouWantToDelet {
    return Intl.message(
      'Are You Sure You Want To delete',
      name: 'areYouSureYouWantToDelet',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Add New Category`
  String get addNewCategory {
    return Intl.message(
      'Add New Category',
      name: 'addNewCategory',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `Client Name: `
  String get client {
    return Intl.message('Client Name: ', name: 'client', desc: '', args: []);
  }

  /// `Total Profit `
  String get totalProfit {
    return Intl.message(
      'Total Profit ',
      name: 'totalProfit',
      desc: '',
      args: [],
    );
  }

  /// `Total Product Sold Today `
  String get totalProductSoldToday {
    return Intl.message(
      'Total Product Sold Today ',
      name: 'totalProductSoldToday',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
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
