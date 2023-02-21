import 'package:flutter/material.dart';
import 'package:foodcourt/pages/onboard_screen/onboard_bttom_sheet.dart';
import 'package:foodcourt/pages/onboard_screen/onboard_item.dart';
import 'package:foodcourt/util/colors.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(bottom: 80),
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() => isLastPage = index == 2);
              },
              children: const [
                OnboardItem(
                  backgroundImage: "assets/images/cloudy.png",
                  title1: "Detailed Hourly \nForecast",
                  title2: "Get in - depth weather \n information",
                ),
                OnboardItem(
                  backgroundImage: "assets/images/sun.png",
                  title1: "Real-Time \nWeather Map",
                  title2:
                      "Watch the progress of the \nprecipitation to stay informed",
                ),
                OnboardItem(
                  backgroundImage: "assets/images/rainandcloudy.png",
                  title1: "Weather Around the World",
                  title2:
                      "Add any location you want and \nswipe easily to change",
                ),
              ],
            ),
          ),
        ),
        bottomSheet: OnboardBottomSheet(
          controller: controller,
          isLastPage: isLastPage,
        ));
  }
}
