import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/data/models/activity.dart';

import '../../../data/models/patient.dart';

class NewActivityController extends GetxController {

  late Patient patient;
  final durationController = TextEditingController();
  final startingTimeController = TextEditingController();
  final periodController = TextEditingController();
  var activities = <Activity>[].obs;
  var checkedActivity = Activity(id: '', name: '', duration: '', startingTime: '', period: '').obs;

  @override
  void onInit() {
    patient = Get.arguments as Patient;
    super.onInit();
    fetchPatientDetails();
    print(patient.email);
  }

  void fetchPatientDetails() async {
    await Future.delayed(const Duration(seconds: 4));

    final List<Activity> dummyActivities = [
      Activity(id: '0', name: 'Squats', duration: '10', startingTime: '15:00', period: '30'),
      Activity(id: '1', name: 'Push-ups', duration: '10', startingTime: '15:00', period: '30'),
      Activity(id: '2', name: 'Plank', duration: '10', startingTime: '15:00', period: '30'),
      Activity(id: '3', name: 'Deadlift', duration: '10', startingTime: '15:00', period: '30'),
      Activity(id: '4', name: 'Bench-press', duration: '10', startingTime: '15:00', period: '30'),
      Activity(id: '5', name: 'Lunge', duration: '10', startingTime: '15:00', period: '30')
    ];

    activities.value = dummyActivities;
  }

  void setActivity(Activity activity) {
    checkedActivity.value = activity;
  }

  void assignNewActivity() {
    checkedActivity.value.duration = durationController.text;
    checkedActivity.value.startingTime = startingTimeController.text;
    checkedActivity.value.period = periodController.text;
    print(checkedActivity.value.toString());
  }

  @override
  void onClose() {
    durationController.dispose();
    startingTimeController.dispose();
    periodController.dispose();
    super.onClose();
  }
}
