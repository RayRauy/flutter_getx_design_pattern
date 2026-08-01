import 'package:get/get.dart';

import '../../data/access_token.dart';

class SplashController extends GetxController {

  var loading = true.obs;

  @override
  void onInit() {
    _checkLogin();
    super.onInit();
  }

  void _checkLogin() async {
    loading.value = true;
    await Future.delayed(Duration(seconds: 3));
    loading.value = false;
    if(AccessToken.getToken().isNotEmpty){
      Get.offNamed("/home");
    }else {
      Get.offNamed("/login");
    }
  }

}