import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/patient.dart';
import '../../../http_controller.dart';
import '../../../user_controller.dart';

class MyPatientsController extends GetxController {
  final HttpController httpController = Get.put(HttpController());
  final UserController userController = Get.find<UserController>();
  final emailController = TextEditingController();
  var patients = <Patient>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    isLoading.value = true;
    try {
      patients.value = await httpController.fetchPatientsByDoctorId(userController.user.value!.id!);
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> assignPatient() async {
    try {
      await httpController.assignPatientToDoctor(
        emailController.text,
        userController.user.value!.id!
      );
      await fetchPatients();
    } catch (error) {
      Get.snackbar('Error', '$error');
      print('Error: $error');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
