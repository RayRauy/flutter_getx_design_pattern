import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: controller.loading.value == false ? Center(): Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    });

  }
}
