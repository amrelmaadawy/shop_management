import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/home/ui/home_view.dart';
import 'package:small_managements/features/products/ui/products_view.dart';
import 'package:small_managements/features/reports/ui/reports_view.dart';
import 'package:small_managements/features/sales/ui/sales_view.dart';
import 'package:small_managements/features/settings/ui/settings_view.dart';
import 'package:small_managements/generated/l10n.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  List<Widget> pages = [
    HomeView(),
    ProductsView(),
    SalesView(),
    ReportsView(),
    SettingsView(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
      
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: AppColors.kButtonNavBarColor,
        unselectedLabelStyle: TextStyle(color: AppColors.kPrimeryColor),
        unselectedItemColor: AppColors.kPrimeryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: S.of(context).home),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label:  S.of(context).products),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label:  S.of(context).sales,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem),
            label:  S.of(context).reports,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label:  S.of(context).settings,
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
