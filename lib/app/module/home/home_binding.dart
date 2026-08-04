import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/module/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> HomeController());
  }

}