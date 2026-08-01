import 'package:flutter/material.dart';
import 'package:flutter_getx_design_pattern/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: controller.loading.value == false
            ? Center()
            : Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    });
  }
}
