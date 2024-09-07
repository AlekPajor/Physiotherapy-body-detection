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
      Patient(id: '1', firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com'),
      Patient(id: '2', firstName: 'Jane', lastName: 'Smith', email: 'jane.smith@example.com'),
      Patient(id: '3', firstName: 'Alice', lastName: 'Johnson', email: 'alice.johnson@example.com'),
      Patient(id: '4', firstName: 'Bob', lastName: 'Brown', email: 'bob.brown@example.com'),
      Patient(id: '5', firstName: 'Charlie', lastName: 'Davis', email: 'charlie.davis@example.com'),
      Patient(id: '6', firstName: 'David', lastName: 'Evans', email: 'david.evans@example.com'),
      Patient(id: '7', firstName: 'Eva', lastName: 'Wilson', email: 'eva.wilson@example.com'),
      Patient(id: '8', firstName: 'Grace', lastName: 'Miller', email: 'grace.miller@example.com'),
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
