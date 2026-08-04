import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/module/auth/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> LoginController());
  }

}