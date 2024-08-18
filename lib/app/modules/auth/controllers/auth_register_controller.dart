import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRegisterController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var registrationType = 'Patient'.obs;

  void register() {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    if (firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      if (registrationType.value == 'Patient') {
        // register patient
        Get.snackbar('Success', 'Registration as patient succeeded');
      } else if (registrationType.value == 'Doctor') {
        // register doctor
        Get.snackbar('Success', 'Registration as doctor succeeded');
      }
      Get.offAllNamed('/login');
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
