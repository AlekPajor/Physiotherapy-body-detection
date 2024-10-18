import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/data/models/user.dart';

import '../../../data/models/activity.dart';
import '../../../user_controller.dart';

class AuthLoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final email = emailController.text;
    final password = passwordController.text;
    final UserController userController = Get.find<UserController>();

    if (email.isNotEmpty && password.isNotEmpty) {

      var response = 'PATIENT';

      if (response == 'DOCTOR') {
        userController.setUser(User(id: '20', firstName: 'Doctor', lastName: 'Doctorinho', email: 'doctor.doctorinho@example.com'));
        Get.offAllNamed('/my-patients');
      } else if (response == 'PATIENT') {
        userController.setUser(User(id: '1', firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com'));
        userController.user.value?.currentActivity = Activity(
            id: '1',
            name: 'Push-ups',
            duration: '30',
            startingTime: '16:00',
            period: '30'
        );
        Get.offAllNamed('/home');
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
