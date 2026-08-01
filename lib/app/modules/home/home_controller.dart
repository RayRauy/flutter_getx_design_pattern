import 'package:get/get.dart';

import '../../data/access_token.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  Future<void> onLogout() async{
    loading.value = true;
    AccessToken.removeToken();
    await Future.delayed(Duration(seconds: 2));
    loading.value = false;
    Get.offNamed("/login");
  }
}