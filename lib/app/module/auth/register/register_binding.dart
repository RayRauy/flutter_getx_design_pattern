import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/module/auth/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
