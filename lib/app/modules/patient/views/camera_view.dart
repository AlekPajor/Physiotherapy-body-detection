import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/components/pose_detection_widget.dart';
import '../controllers/camera_controller.dart';

class CameraView extends GetView<CameraController> {
  const CameraView({super.key});
  @override
  Widget build(BuildContext context) {
    return PoseDetectionWidget(
      title: 'Pose Detector',
      customPaint: controller.customPaint,
      text: controller.text,
      onImage: (inputImage) {
        controller.processImage(inputImage);
      },
    );
  }
}