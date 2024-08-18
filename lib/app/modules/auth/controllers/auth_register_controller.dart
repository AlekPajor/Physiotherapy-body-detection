import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRegisterController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void registerPatient() {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    if (firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // Perform registration
      Get.snackbar('Success', 'Registration as patient successful!');
    } else {
      Get.snackbar('Error', 'Please fill in all fields');
    }
  }

  void registerDoctor() {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    if (firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // Perform registration
      Get.snackbar('Success', 'Registration as doctor successful!');
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
