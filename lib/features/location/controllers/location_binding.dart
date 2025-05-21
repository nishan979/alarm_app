import 'package:get/get.dart';
import 'location_controller.dart';

class LocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationController());
  }
}
