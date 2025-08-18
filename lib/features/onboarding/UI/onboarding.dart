import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:small_managements/core/utils/app_colors.dart';
import 'package:small_managements/features/home/ui/main_home_view.dart';
import 'package:small_managements/features/onboarding/UI/widgets/build_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            BuildPage(
              imagePath: 'assets/images/onboarding1.png',
              title: 'Manage Inventory Easily',
              describtion: 'Track your products and stock anytime, anywhere.',
            ),
            BuildPage(
              imagePath: 'assets/images/onboarding2.png',
              title: 'Ready Invoices and Reports',
              describtion:
                  'Easily create and download PDF invoices for your sales.',
            ),
            BuildPage(
              imagePath: 'assets/images/onboarding3.png',
              title: 'Get Started Now and See the Difference',
              describtion: '',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kBlueElevatedButtonDarkMode,
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MainHomeView()),
                    );
                  },
                  child: Text(
                    'Get Start',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(
              height: 80,
                  
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      pageController.jumpToPage(2);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(color:AppColors.kBlueElevatedButtonDarkMode),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      onDotClicked: (index) => pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                      controller: pageController,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor:AppColors.kBlueElevatedButtonDarkMode,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: AppColors.kBlueElevatedButtonDarkMode),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
