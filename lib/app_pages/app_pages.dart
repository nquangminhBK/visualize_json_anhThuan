import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visualize_the_json_web/screens/main_screen/main_screen.dart';
import 'package:visualize_the_json_web/screens/main_screen/main_screen_binding.dart';

import 'app_routes.dart';

class AppPages {
  //static const INITIAL_ROUTE = Routes.onboardingRoute;
  static const initialRoute = Routes.mainRoute;
  static final routes = [
    GetPage(
        name: Routes.mainRoute,
        page: () => const MainScreen(),
        binding: MainScreenBinding(),
        transition: Transition.fadeIn),
  ];
}
