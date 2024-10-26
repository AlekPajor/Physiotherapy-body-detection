import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../user_controller.dart';

class AuthRegisterController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final UserController userController = Get.find<UserController>();
  var role = 'PATIENT'.obs;

  Future<void> register() async {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final userRole = role.toString();

    if (firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      try {
        await userController.register(email, password, firstName, lastName, userRole);
        Get.toNamed('/login');
      } catch(error) {
        Get.snackbar('Error', '$error');
      }
    } else {
      Get.snackbar('Error', 'Please fill in all fields');
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
