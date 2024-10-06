import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/video_player_widget.dart';
import '../../../data/maps/activity_video_map.dart';
import '../../../data/models/activity.dart';
import '../../../data/models/report.dart';
import '../../../user_controller.dart';

class ProfileController extends GetxController {
  final UserController userController = Get.find<UserController>();
  var reports = <Report>[].obs;
  var currentActivity = Rxn<Activity>();

  @override
  void onInit() {
    super.onInit();
    fetchPatientDetails();
  }

  void playVideo() {
    String? videoPath = activityVideoMap[currentActivity.value?.name];
    if (videoPath != null) {
      Get.dialog(
        VideoPlayerWidget(videoPath: videoPath),
        barrierDismissible: true,
      );
    } else {
      Get.snackbar(
        'No Video',
        'No instructional video available for this activity.',
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
      );
    }
  }

  void fetchPatientDetails() async {
    await Future.delayed(const Duration(seconds: 4));

    final activity = Activity(
        id: '1',
        name: 'Push-ups',
        duration: '30',
        startingTime: '16:00',
        period: '30'
    );

    final List<Report> dummyReports = [
      Report(id: '1', activityName: 'Squats', date: '27.08', time: '16:01', correctness: '98%'),
      Report(id: '2', activityName: 'Squats', date: '26.08', time: '16:03', correctness: '91%'),
      Report(id: '3', activityName: 'Push-ups', date: '25.08', time: '15:54', correctness: '92%'),
      Report(id: '4', activityName: 'Push-ups', date: '24.08', time: '16:07', correctness: '88%'),
      Report(id: '5', activityName: 'Push-ups', date: '23.08', time: '16:00', correctness: '81%'),
      Report(id: '6', activityName: 'Squats', date: '22.08', time: '16:02', correctness: '95%'),
      Report(id: '7', activityName: 'Push-ups', date: '21.08', time: '15:59', correctness: '93%'),
    ];

    reports.value = dummyReports;
    currentActivity.value = activity;
  }
}
