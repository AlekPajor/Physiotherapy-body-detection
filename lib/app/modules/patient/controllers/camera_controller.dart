import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../../../components/pose_painter.dart';
import '../../../data/models/activity.dart';
import '../../../user_controller.dart';

class CameraScreenController extends GetxController {
  UserController userController = Get.find<UserController>();
  final PoseDetector _poseDetector =
  PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  Rx<CustomPaint?> customPaint = Rx<CustomPaint?>(null);
  String? text;
  late Activity currentActivity;

  @override
  void onInit() {
    super.onInit();
    currentActivity = userController.user.value!.currentActivity!;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _canProcess = false;
    _poseDetector.close();
    super.onClose();
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess || _isBusy) return;

    _isBusy = true;

    final poses = await _poseDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.inputImageData!.size,
        inputImage.inputImageData!.imageRotation,
      );
      customPaint.value = CustomPaint(painter: painter);
    } else {
      customPaint.value = null;
    }

    _isBusy = false;
    update();
  }
}
