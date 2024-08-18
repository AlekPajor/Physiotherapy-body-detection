import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/patient_controller.dart';

class PatientView extends GetView<PatientController> {
  const PatientView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PatientView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PatientView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
