import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:flutter_getx_design_pattern/app/data/access_token.dart';

class LoginController extends GetxController{
  var usernameController = TextEditingController().obs;
  var passswordController = TextEditingController().obs;
  var loading = false.obs;
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
  @override
  void onClose() {
    usernameController.value.dispose();
    passswordController.value.dispose();
    super.onClose();
  }

  Future<void> onLogin() async{
    var username = usernameController.value.text;
    var password = passswordController.value.text;
    if(username.isEmpty){
      Get.snackbar("Error", "Username is required");
      return;
    }
    if(password.isEmpty){
      Get.snackbar(("Error"), "Password is required");
      return;
    }
    loading.value = true;
    await Future.delayed(Duration(seconds: 3));
    loading.value = false;
    AccessToken.saveToken(
      username: username,
      token: "TOKEN",
      refresh: "REFRESH",
    );
    Get.offNamed("/home");
  }
}