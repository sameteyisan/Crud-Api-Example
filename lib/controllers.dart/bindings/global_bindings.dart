import 'package:get/instance_manager.dart';
import 'package:task/controllers.dart/global_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
  }
}
