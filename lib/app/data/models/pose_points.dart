import 'dart:math';

class PosePoints {
  final Point leftWrist;
  final Point leftElbow;
  final Point leftShoulder;
  final Point rightWrist;
  final Point rightElbow;
  final Point rightShoulder;
  final Point leftHip;
  final Point leftKnee;
  final Point leftAnkle;
  final Point rightHip;
  final Point rightKnee;
  final Point rightAnkle;

  PosePoints({
    required this.leftWrist,
    required this.leftElbow,
    required this.leftShoulder,
    required this.rightWrist,
    required this.rightElbow,
    required this.rightShoulder,
    required this.leftHip,
    required this.leftKnee,
    required this.leftAnkle,
    required this.rightHip,
    required this.rightKnee,
    required this.rightAnkle,
  });
}