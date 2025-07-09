import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/home/ui/home_view.dart';
import 'package:small_managements/features/products/ui/products_view.dart';
import 'package:small_managements/features/reports/ui/reports_view.dart';
import 'package:small_managements/features/sales/ui/sales_view.dart';
import 'package:small_managements/features/settings/ui/settings_view.dart';

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
        unselectedLabelStyle: TextStyle(color: AppColors.kUnselectedIconColor),
        unselectedItemColor: AppColors.kUnselectedIconColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Products'),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem),
            label: 'reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
