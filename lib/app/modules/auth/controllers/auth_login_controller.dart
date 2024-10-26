import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/data/models/user.dart';

import '../../../data/models/activity.dart';
import '../../../user_controller.dart';

class AuthLoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final UserController userController = Get.find<UserController>();

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        await userController.login(emailController.text, passwordController.text);
        if (userController.user.value!.role == 'DOCTOR') {
          Get.offAllNamed('/my-patients');
        } else if (userController.user.value!.role == 'PATIENT') {
          Get.offAllNamed('/home');
        } else {
          Get.snackbar('Error', 'Something went wrong');
        }
      } catch(error) {
        Get.snackbar('Error', '$error');
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
