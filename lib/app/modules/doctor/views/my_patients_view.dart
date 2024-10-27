import 'package:flutter/material.dart';
import 'dart:core';
import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/data/models/patient.dart';
import 'package:physiotherapy_body_detection/app/modules/doctor/views/patient_details_view.dart';
import '../bindings/patient_details_binding.dart';
import '../controllers/my_patients_controller.dart';

class MyPatientsView extends GetView<MyPatientsController> {
  const MyPatientsView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight * 0.4;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "My Patients",
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: cardHeight,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange[900],
                          ),
                        );
                      } else {
                        if(controller.patients.isEmpty) {
                          return Center(
                            child: Text(
                              "No patients assigned",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[900]
                              ),
                            )
                          );
                        }
                      }
                      return ListView.builder(
                        itemCount: controller.patients.length,
                        itemBuilder: (context, index) {
                          final patient = controller.patients[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange[900],
                              child: Text(
                                patient.firstName[0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              '${patient.firstName} ${patient.lastName}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                                fontSize: 16
                              ),
                            ),
                            subtitle: Text(
                              patient.email,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 10
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[900],
                            ),
                            onTap: () {
                              Get.to(() => const PatientDetailsView(), arguments: patient, binding: PatientDetailsBinding());
                            },
                            splashColor: Colors.transparent,
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Text(
                "Assign patient",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 10),
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(50.0),
                child: TextField(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[900],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange[900]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                      gapPadding: 5,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange[900]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                      gapPadding: 5,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    floatingLabelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.orange[900],
                    ),
                    hintText: "Type patient email...",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  WidgetStatePropertyAll(Colors.orange[900]),
                  foregroundColor:
                  WidgetStatePropertyAll(Colors.grey[200]),
                  elevation: const WidgetStatePropertyAll(4),
                ),
                onPressed: () => controller.assignPatient(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_rounded),
                    SizedBox(width: 6),
                    Text(
                      'Add patient',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
