import 'package:flutter/material.dart';
import 'package:flutter_getx_design_pattern/app/widgets/custom_button_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/module/auth/register/register_controller.dart';

import '../../../widgets/custom_input_widget.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Register", style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomInputWidget(
                        controller: controller.firstNameController.value,
                        label: "First Name",
                        hintText: "First Name",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomInputWidget(
                        controller: controller.lastNameController.value,
                        label: "Last Name",
                        hintText: "Last Name",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomInputWidget(
                  controller: controller.usernameController.value,
                  label: "Username",
                  hintText: "Username",
                ),
                const SizedBox(height: 16),
                CustomInputWidget(
                  controller: controller.emailController.value,
                  label: "Email",
                  hintText: "Email",
                ),
                const SizedBox(height: 16),
                CustomInputWidget(
                  controller: controller.phoneNumberController.value,
                  label: "Phone Number",
                  hintText: "Phone Number",
                ),
                const SizedBox(height: 16),
                CustomInputWidget(
                  controller: controller.passwordController.value,
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
                const SizedBox(height: 16),
                CustomInputWidget(
                  controller: controller.confirmPasswordController.value,
                  label: "Confirm Password",
                  hintText: "Confirm Password",
                  obscureText: controller.isConfirmPasswordHidden.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfirmPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: controller.toggleConfirmPasswordVisibility,
                  ),
                ),
                const SizedBox(height: 35),
                CustomButtonWidget(
                  loading: controller.loading.value,
                  label: "Register",
                  onclick: () {
                    controller.onRegister();
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
