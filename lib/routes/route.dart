import 'package:foodcourt/pages/carousel_screen/carousel_page.dart';
import 'package:foodcourt/pages/details_screen/details.dart';
import 'package:foodcourt/pages/home_screen/home.dart';
import 'package:foodcourt/pages/onboard_screen/onboarding.dart';
import 'package:foodcourt/pages/splah_screen/splashscreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class RouteHelper {
  static const String initial = "/initial";
  static const String onboarding = "/onboarding";
  static const String home = "/home";
  static const String details = "/details";
  static const String carousel = "/carousel";

  static String getInitialPage() => initial;
  static String getOnboardingPage() => onboarding;
  static String getHomePage() => home;
  static String getDetailsPage() => details;
  static String getCarouselPage() => carousel;

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => const SplashScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: onboarding,
        page: () => const Onboarding(),
        transition: Transition.fadeIn),
    GetPage(
        name: home,
        page: () => const HomeScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: details,
        page: () => const DetailsScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: carousel,
        page: () => const CarouselPage(),
        transition: Transition.fadeIn)
  ];
}
