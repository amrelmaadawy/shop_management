import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_managements/core/services/check_updates.dart';
import 'package:small_managements/features/home/logic/home_provider.dart';
import 'package:small_managements/features/home/ui/home_view.dart';
import 'package:small_managements/features/products/ui/products_view.dart';
import 'package:small_managements/features/reports/ui/reports_view.dart';
import 'package:small_managements/features/sales/ui/sales_view.dart';
import 'package:small_managements/features/settings/ui/settings_view.dart';
import 'package:small_managements/generated/l10n.dart';

class MainHomeView extends ConsumerStatefulWidget {
  const MainHomeView({super.key});

  @override
  ConsumerState<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends ConsumerState<MainHomeView> {
  List<Widget> pages = [
    HomeView(),
    ProductsView(),
    SalesView(),
    ReportsView(),
    SettingsView(),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UpdateChecker.checkForUpdates(context);
    });
  }

  @override
  Widget build(BuildContext context) {
   final currentindex=  ref.watch(bottomNavBarProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          ref.read(bottomNavBarProvider.notifier).state = index;
        },
        currentIndex: currentindex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cube_box),
            label: S.of(context).products,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar),
            label: S.of(context).sales,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar),
            label: S.of(context).reports,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings_solid),
            label: S.of(context).settings,
          ),
        ],
      ),
      body: pages[currentindex],
    );
  }
}
