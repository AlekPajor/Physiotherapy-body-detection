import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/http_controller.dart';

import '../../../components/video_player_widget.dart';
import '../../../data/maps/activity_video_map.dart';
import '../../../data/models/activity.dart';
import '../../../data/models/report.dart';
import '../../../user_controller.dart';

class ProfileController extends GetxController {
  final HttpController httpController = Get.put(HttpController());
  final UserController userController = Get.find<UserController>();
  var reports = <Report>[].obs;
  var currentActivity = Rxn<Activity>();
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    currentActivity.value = userController.user.value?.currentActivity;
    await fetchReports();
  }

  void playVideo() {
    String? videoPath = activityVideoMap[currentActivity.value?.exercise.name];
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

  Future<void> fetchReports() async {
    isLoading.value = true;
    reports.value = await httpController.fetchReportsByUserId(userController.user.value!.id!);
    isLoading.value = false;
  }
}
