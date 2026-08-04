import 'package:get/get.dart';

import '../../data/access_token.dart';

class SplashController extends GetxController {

  Future<void> _checklogin() async {
    loading.value = true;
    await Future.delayed(Duration(seconds:3));
    loading.value = false;
    if(AccessToken.getToken().isNotEmpty){
      Get.offNamed("/home");
    }else{
      Get.offNamed("/login");
    }
  }
  var loading = true.obs;
  @override
  void onInit() {
    _checklogin();
    super.onInit();
  }
}
