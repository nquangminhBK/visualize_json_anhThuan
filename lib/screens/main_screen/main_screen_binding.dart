import 'package:get/get.dart';
import 'package:visualize_the_json_web/screens/main_screen/main_screen_controller.dart';

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
  }
}
