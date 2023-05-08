import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visualize_the_json_web/app_pages/app_routes.dart';
import 'package:visualize_the_json_web/shared_preferences.dart';

import 'app_pages/app_pages.dart';

void main() async {
  Get.put<SharedPreferences>(SharedPreferences());
  await Get.find<SharedPreferences>().openHiveBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: UniqueKey(),
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      enableLog: true,
      navigatorKey: Get.key,
      initialRoute: Routes.mainRoute,
      getPages: AppPages.routes,
    );
  }
}
