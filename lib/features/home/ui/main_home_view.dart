import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/home/ui/home_view.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        currentIndex: 1,
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
      body: HomeView(),
    );
  }
}
