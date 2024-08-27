import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/patient.dart';

class MyPatientsController extends GetxController {

  final emailController = TextEditingController();
  var patients = <Patient>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPatients();
  }

  void fetchPatients() async {
    await Future.delayed(const Duration(seconds: 2));

    final List<Patient> dummyPatients = [
      Patient(firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com'),
      Patient(firstName: 'Jane', lastName: 'Smith', email: 'jane.smith@example.com'),
      Patient(firstName: 'Alice', lastName: 'Johnson', email: 'alice.johnson@example.com'),
      Patient(firstName: 'Bob', lastName: 'Brown', email: 'bob.brown@example.com'),
      Patient(firstName: 'Charlie', lastName: 'Davis', email: 'charlie.davis@example.com'),
      Patient(firstName: 'David', lastName: 'Evans', email: 'david.evans@example.com'),
      Patient(firstName: 'Eva', lastName: 'Wilson', email: 'eva.wilson@example.com'),
      Patient(firstName: 'Grace', lastName: 'Miller', email: 'grace.miller@example.com'),
    ];

    patients.value = dummyPatients;
  }

  void addPatient() {
    // Add patient logic
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
