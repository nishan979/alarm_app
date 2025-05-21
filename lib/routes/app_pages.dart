

import 'package:alarmapp/features/home/screens/home_screen.dart';
import 'package:alarmapp/features/location/controllers/location_binding.dart';
import 'package:alarmapp/features/location/screens/location_screen.dart';
import 'package:alarmapp/features/onboarding/controllers/onboarding_binding.dart';
import 'package:alarmapp/features/onboarding/screens/onboarding_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.location,
      page: () => const LocationScreen(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      // Add home binding later
    ),
  ];
}

abstract class Routes {
  static const onboarding = '/onboarding';
  static const location = '/location';
  static const home = '/home';
}