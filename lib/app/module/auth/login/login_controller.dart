import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/data/access_token.dart';
import 'package:flutter_getx_design_pattern/app/module/auth/repository/auth_repository.dart';

class LoginController extends GetxController {
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var loading = false.obs;
  var isPasswordHidden = true.obs;
  final authRepository = Get.find<AuthRepository>();

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  @override
  void onClose() {
    usernameController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }

  Future<void> onLogin() async {
    var username = usernameController.value.text;
    var password = passwordController.value.text;
    if (username.isEmpty) {
      Get.snackbar("Error", "Username is required");
      return;
    }
    if (password.isEmpty) {
      Get.snackbar("Error", "Password is required");
      return;
    }
    loading.value = true;
    await Future.delayed(Duration(seconds: 2));
    loading.value = false;

    var loginResponse = await authRepository.login(
      username: username,
      password: password,
    );
    if (loginResponse.accessToken != null) {
      AccessToken.saveToken(
        username: username,
        token: loginResponse.accessToken,
        refresh: loginResponse.refreshToken,
      );
      Get.offNamed("/home");
    } else {
      Get.snackbar("Error", "Your username and password incorrect");
    }
  }
}
