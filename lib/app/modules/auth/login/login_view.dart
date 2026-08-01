import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_getx_design_pattern/app/modules/auth/login/login_controller.dart';
import 'package:flutter_getx_design_pattern/app/widget/custom_button_widget.dart';
import 'package:flutter_getx_design_pattern/app/widget/custom_input_widget.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          title: Text("Login", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInputWidget(
                  controller: controller.usernameController.value,
                  label: "Username", hintText: "Username"),
              CustomInputWidget(
                controller: controller.passswordController.value,
                label: "Password",
                hintText: "Password",
                obscureText: controller.isPasswordHidden.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
              SizedBox(height: 35,),
              CustomButtonWidget(
                loading: controller.loading.value,
                label: "login",
                onClick: (){
                  controller.onLogin();

                },
              )
            ],
          ),
        ),
      );
    });
  }
}
