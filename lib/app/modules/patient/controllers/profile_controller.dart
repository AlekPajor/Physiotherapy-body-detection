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
    currentActivity.value = userController.user.value!.currentActivity;
    fetchReports();
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

  void fetchReports() async {
    // get all reports
  }
}
