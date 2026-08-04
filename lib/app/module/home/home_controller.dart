import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/data/access_token.dart';

class HomeController extends GetxController {

  var loading = false.obs;
  onLogout()async{
    loading.value = true;
    AccessToken.removeToken();
    await Future.delayed(Duration(seconds: 2));
    loading.value = false;
    Get.offNamed("/login");
  }

}