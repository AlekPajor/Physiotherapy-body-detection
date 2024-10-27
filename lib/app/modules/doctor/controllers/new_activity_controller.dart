import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/data/models/activity.dart';
import 'package:physiotherapy_body_detection/app/data/models/exercise.dart';
import 'package:physiotherapy_body_detection/app/modules/doctor/controllers/patient_details_controller.dart';

import '../../../data/models/patient.dart';
import '../../../http_controller.dart';

class NewActivityController extends GetxController {
  final HttpController httpController = Get.put(HttpController());
  late Patient patient;
  final durationController = TextEditingController();
  final startingTimeController = TextEditingController();
  final periodController = TextEditingController();
  var exercises = <Exercise>[].obs;
  var checkedExercise = Rx<Exercise?>(null);
  var isLoading = false.obs;

  @override
  void onInit() async {
    patient = Get.arguments as Patient;
    super.onInit();
    await fetchExercises();
  }

  void setExercise(Exercise exercise) {
    checkedExercise.value = exercise;
  }

  Future<void> fetchExercises() async {
    isLoading.value = true;
    try {
      exercises.value = await httpController.fetchAllExercises();
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> assignNewActivity() async {
    if(checkedExercise.value == null || durationController.text.isEmpty || startingTimeController.text.isEmpty || periodController.text.isEmpty) {
      Get.snackbar('Error', 'Fill in all the fields and check activity to assign');
    } else {
      try {
        await httpController.assignNewExercise(
            patient.id!,
            checkedExercise.value!.id!,
            durationController.text,
            startingTimeController.text,
            periodController.text
        );
        Get.back();
      } catch (error) {
        Get.snackbar('Error', '$error');
        print('Error: $error');
      }
    }
  }

  @override
  void onClose() {
    durationController.dispose();
    startingTimeController.dispose();
    periodController.dispose();
    super.onClose();
  }
}
