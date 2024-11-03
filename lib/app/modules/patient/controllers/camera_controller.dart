import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:intl/intl.dart';
import 'package:physiotherapy_body_detection/app/data/models/snapshot.dart';

import '../../../components/pose_painter.dart';
import '../../../data/models/activity.dart';
import '../../../data/maps/activity_time_map.dart';
import '../../../data/models/points.dart';
import '../../../data/models/pose_points.dart';
import '../../../http_controller.dart';
import '../../../user_controller.dart';

class CameraScreenController extends GetxController {
  final HttpController httpController = Get.put(HttpController());
  UserController userController = Get.find<UserController>();
  final PoseDetector _poseDetector =
  PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  Rx<CustomPaint?> customPaint = Rx<CustomPaint?>(null);
  String? text;
  var currentActivity = Rxn<Activity>();
  late List<Snapshot> snapshotsCopy;
  InputImage? currentImage;
  late int activityTime;
  List<Snapshot> userActivitySnapshots = [];
  Snapshot? currentlyCheckedSnapshot;
  int? correctness;
  var activityEnded = false.obs;

  @override
  void onInit() {
    super.onInit();
    currentActivity.value = userController.user.value?.currentActivity;
    snapshotsCopy = List<Snapshot>.from(currentActivity.value!.exercise.snapshots);
    activityTime = activityTimeMap[currentActivity.value?.exercise.name]!;
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

  void setCurrentImage(InputImage inputImage) {
    currentImage = inputImage;
    update();
  }

  void setActivityEnded(bool ended) {
    activityEnded.value = ended;
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

  Future<void> endActivity() async {
    print("User activity snapshots: " + "${userActivitySnapshots.length}");
    print("Original snapshots: " + "${currentActivity.value?.exercise.snapshots.length}");

    int totalPoints = 0;
    int maxPoints = userActivitySnapshots.length * 4;

    for (final userSnapshot in userActivitySnapshots) {
      final activitySnapshot = currentActivity.value?.exercise.snapshots.firstWhere((element) =>
        element.time == userSnapshot.time,
      );

      if ((userSnapshot.points.leftElbow - activitySnapshot!.points.leftElbow).abs() <= 20) {
        totalPoints += 1;
      }
      if ((userSnapshot.points.rightElbow - activitySnapshot.points.rightElbow).abs() <= 20) {
        totalPoints += 1;
      }
      if ((userSnapshot.points.leftKnee - activitySnapshot.points.leftKnee).abs() <= 20) {
        totalPoints += 1;
      }
      if ((userSnapshot.points.rightKnee - activitySnapshot.points.rightKnee).abs() <= 20) {
        totalPoints += 1;
      }
    }

    int correctnessPercentage = ((totalPoints / maxPoints) * 100).floor();
    correctness = correctnessPercentage;
    print("Activity %%%%%%%%%%%%%%%%%%%%%%%%%% ended");
    print("correctnessPercentage: " + "$correctnessPercentage");
    await sendReport();
    activityEnded.value = true;
  }


  void startActivity() {
    print("activity start");
    activityEnded.value = false;
    for (final snapshot in snapshotsCopy) {
      snapshot.timeInMillis = parseSnapshotTime(snapshot.time);
    }

    print("added millis to snapshot copy");
    int startTime = DateTime.now().millisecondsSinceEpoch;

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      int elapsed = DateTime.now().millisecondsSinceEpoch - startTime;

      if (elapsed >= activityTime) {
        timer.cancel();
        endActivity();
        return;
      }

      checkSnapshots(elapsed);
    });
  }

  int parseSnapshotTime(String time) {
    final parts = time.split(':');
    final minutes = int.parse(parts[0]);
    final seconds = int.parse(parts[1]);
    final milliseconds = int.parse(parts[2]);

    return (minutes * 60 * 1000) + (seconds * 1000) + milliseconds;
  }

  Future<void> checkSnapshots(int elapsedMillis) async {
    var snapshotsToCheck = List<Snapshot>.from(snapshotsCopy);

    for (final snapshot in snapshotsToCheck) {
      if ((elapsedMillis - snapshot.timeInMillis!).abs() <= 100) {
        print("elapsedMillis: " + "$elapsedMillis");
        print("snapshot timeInMillis: " + "${snapshot.timeInMillis}");
        print("calculated: " + "${elapsedMillis - snapshot.timeInMillis!}");
        currentlyCheckedSnapshot = snapshot;
        await captureAndCalculateAngles();
        snapshotsCopy.removeAt(0);
        print("snapshot removed");
      }
    }
  }

  Future<void> captureAndCalculateAngles() async {
    print("inside captureAndCalculateAngles");
    var detectedPoints = await getPoseFromCameraFeed(currentImage!);

    int leftElbowAngle = calculateAngle(detectedPoints.leftWrist, detectedPoints.leftElbow, detectedPoints.leftShoulder);
    int rightElbowAngle = calculateAngle(detectedPoints.rightWrist, detectedPoints.rightElbow, detectedPoints.rightShoulder);
    int leftKneeAngle = calculateAngle(detectedPoints.leftHip, detectedPoints.leftKnee, detectedPoints.leftAnkle);
    int rightKneeAngle = calculateAngle(detectedPoints.rightHip, detectedPoints.rightKnee, detectedPoints.rightAnkle);

    var points = Points(
      leftElbow: leftElbowAngle,
      rightElbow: rightElbowAngle,
      leftKnee: leftKneeAngle,
      rightKnee: rightKneeAngle
    );

    var snapshot = Snapshot(
      time: currentlyCheckedSnapshot!.time,
      points: points
    );
    userActivitySnapshots.add(snapshot);

    print("Left elbow Angle: $leftElbowAngle");
    print("Right elbow Angle: $rightElbowAngle");
    print("Left knee Angle: $leftKneeAngle");
    print("Right knee Angle: $rightKneeAngle");
  }

  int calculateAngle(Point a, Point b, Point c) {
    print("calculating angles");
    double angle = atan2(c.y - b.y, c.x - b.x) - atan2(a.y - b.y, a.x - b.x);
    angle = (angle * 180 / pi).abs();
    if (angle > 180.0) {
      angle = 360.0 - angle;
    }

    return angle.floor();
  }

  Future<PosePoints> getPoseFromCameraFeed(InputImage inputImage) async {
    print("inside getPoseFromCameraFeed");
    List<Pose> poses = await _poseDetector.processImage(inputImage);
    print("i have pose");

    if (poses.isNotEmpty) {
      final pose = poses.first;

      final leftWrist = pose.landmarks[PoseLandmarkType.leftWrist];
      final leftElbow = pose.landmarks[PoseLandmarkType.leftElbow];
      final leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
      final rightWrist = pose.landmarks[PoseLandmarkType.rightWrist];
      final rightElbow = pose.landmarks[PoseLandmarkType.rightElbow];
      final rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];
      final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
      final leftKnee = pose.landmarks[PoseLandmarkType.leftKnee];
      final leftAnkle = pose.landmarks[PoseLandmarkType.leftAnkle];
      final rightHip = pose.landmarks[PoseLandmarkType.rightHip];
      final rightKnee = pose.landmarks[PoseLandmarkType.rightKnee];
      final rightAnkle = pose.landmarks[PoseLandmarkType.rightAnkle];

      return PosePoints(
        leftWrist: Point(leftWrist?.x.toInt() ?? 0, leftWrist?.y.toInt() ?? 0),
        leftElbow: Point(leftElbow?.x.toInt() ?? 0, leftElbow?.y.toInt() ?? 0),
        leftShoulder: Point(leftShoulder?.x.toInt() ?? 0, leftShoulder?.y.toInt() ?? 0),
        rightWrist: Point(rightWrist?.x.toInt() ?? 0, rightWrist?.y.toInt() ?? 0),
        rightElbow: Point(rightElbow?.x.toInt() ?? 0, rightElbow?.y.toInt() ?? 0),
        rightShoulder: Point(rightShoulder?.x.toInt() ?? 0, rightShoulder?.y.toInt() ?? 0),
        leftHip: Point(leftHip?.x.toInt() ?? 0, leftHip?.y.toInt() ?? 0),
        leftKnee: Point(leftKnee?.x.toInt() ?? 0, leftKnee?.y.toInt() ?? 0),
        leftAnkle: Point(leftAnkle?.x.toInt() ?? 0, leftAnkle?.y.toInt() ?? 0),
        rightHip: Point(rightHip?.x.toInt() ?? 0, rightHip?.y.toInt() ?? 0),
        rightKnee: Point(rightKnee?.x.toInt() ?? 0, rightKnee?.y.toInt() ?? 0),
        rightAnkle: Point(rightAnkle?.x.toInt() ?? 0, rightAnkle?.y.toInt() ?? 0),
      );
    } else {
      throw Exception("No poses detected in the current frame");
    }
  }

  Future<void> sendReport() async {
    final now = DateTime.now();
    final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
    final DateFormat timeFormatter = DateFormat('HH:mm');
    var date = dateFormatter.format(now);
    var time = timeFormatter.format(now);

    print('got date and time');

    print('USER ID: ' + '${userController.user.value!.id!}');
    print('ACTIVITY ID: ' + '${currentActivity.value!.id!}');
    print('DATE: ' + '${date}');
    print('TIME: ' + '${time}');
    print('CORRECTNESS: ' + '${correctness!}');

    try {
      await httpController.sendReport(
        userController.user.value!.id!,
        currentActivity.value!.id!,
        date,
        time,
        correctness!
      );
      print('sent SUCCESFUL');
    } catch (error) {
      Get.snackbar('Error', '$error');
      print('Error: $error');
    }
  }

}
