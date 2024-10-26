import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/data/models/activity.dart';
import 'package:physiotherapy_body_detection/app/data/models/exercise.dart';

import '../../../data/models/patient.dart';

class NewActivityController extends GetxController {

  late Patient patient;
  final durationController = TextEditingController();
  final startingTimeController = TextEditingController();
  final periodController = TextEditingController();
  var exercises = <Exercise>[].obs;
  var checkedExercise = Rx<Exercise?>(null);

  @override
  void onInit() {
    patient = Get.arguments as Patient;
    super.onInit();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    // get all exercises
  }

  void setExercise(Exercise exercise) {
    checkedExercise.value = exercise;
  }

  void assignNewActivity() {
    Activity(
      duration: durationController.text,
      startingTime: startingTimeController.text,
      period: periodController.text,
      exercise: checkedExercise.value!
    );

    // assign exercise
  }

  @override
  void onClose() {
    durationController.dispose();
    startingTimeController.dispose();
    periodController.dispose();
    super.onClose();
  }
}
