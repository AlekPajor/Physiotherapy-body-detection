import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthLoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {

      var response = 'PATIENT';

      if (response == 'DOCTOR') {
        Get.offAllNamed('/doctor');
      } else if (response == 'PATIENT') {
        Get.offAllNamed('/patient');
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }

    } else {
      Get.snackbar('Error', 'Please fill in all fields');
    }

  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
