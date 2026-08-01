import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/modules/home/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> HomeController());
  }

}