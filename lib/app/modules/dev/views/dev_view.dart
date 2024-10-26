import 'dart:async';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:screenshot/screenshot.dart';

class PoseDetectionVideoScreen extends StatefulWidget {
  final String videoPath;

  PoseDetectionVideoScreen({required this.videoPath});

  @override
  _PoseDetectionVideoScreenState createState() =>
      _PoseDetectionVideoScreenState();
}

class _PoseDetectionVideoScreenState extends State<PoseDetectionVideoScreen> {
  late VideoPlayerController _controller;
  final PoseDetector _poseDetector = PoseDetector(options: PoseDetectorOptions());
  final ScreenshotController _screenshotController = ScreenshotController();
  Timer? _timer;

  List<double> _angles = [];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _startFrameProcessing();
      });
  }

  void _startFrameProcessing() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) async {
      if (_controller.value.isPlaying) {
        print("Video is playing..."); // Debugging line
        // Capture a screenshot of the current video frame
        final image = await _screenshotController.captureFromWidget(
          VideoPlayer(_controller),
        );
        if (image != null) {
          _processImageForPose(image);
        } else {
          print("Image capture failed."); // Debugging line
        }
      } else {
        print("Video is not playing."); // Debugging line
      }
    });
  }

  Future<void> _processImageForPose(Uint8List image) async {
    final inputImage = InputImage.fromBytes(
      bytes: image,
      inputImageData: InputImageData(
        size: Size(_controller.value.size.width, _controller.value.size.height),
        imageRotation: InputImageRotation.rotation0deg,
        inputImageFormat: InputImageFormat.nv21, // Adjust format if necessary
        planeData: [
          InputImagePlaneMetadata(
            bytesPerRow: _controller.value.size.width.toInt(),
            height: _controller.value.size.height.toInt(),
            width: _controller.value.size.width.toInt(),
          ),
        ],
      ),
    );

    final poses = await _poseDetector.processImage(inputImage);
    print("Detected poses: ${poses.length}"); // Debugging line

    if (poses.isNotEmpty) {
      final pose = poses.first;
      _angles = _calculateAngles(pose);
      print("Angles calculated: $_angles"); // Debugging line
      setState(() {}); // Update UI with angles
    } else {
      print("No poses detected."); // Debugging line
    }
  }

  List<double> _calculateAngles(Pose pose) {
    List<double> angles = [];

    // Calculate angle for left wrist, elbow, and shoulder
    if (pose.landmarks[PoseLandmarkType.leftWrist] != null &&
        pose.landmarks[PoseLandmarkType.leftElbow] != null &&
        pose.landmarks[PoseLandmarkType.leftShoulder] != null) {
      angles.add(_calculateAngle(
          pose.landmarks[PoseLandmarkType.leftWrist]!,
          pose.landmarks[PoseLandmarkType.leftElbow]!,
          pose.landmarks[PoseLandmarkType.leftShoulder]!));
    } else {
      angles.add(double.nan); // or some default value
      print("Left arm landmarks not detected.");
    }

    // Calculate angle for right wrist, elbow, and shoulder
    if (pose.landmarks[PoseLandmarkType.rightWrist] != null &&
        pose.landmarks[PoseLandmarkType.rightElbow] != null &&
        pose.landmarks[PoseLandmarkType.rightShoulder] != null) {
      angles.add(_calculateAngle(
          pose.landmarks[PoseLandmarkType.rightWrist]!,
          pose.landmarks[PoseLandmarkType.rightElbow]!,
          pose.landmarks[PoseLandmarkType.rightShoulder]!));
    } else {
      angles.add(double.nan); // or some default value
      print("Right arm landmarks not detected.");
    }

    // Calculate angle for left hip, knee, and ankle
    if (pose.landmarks[PoseLandmarkType.leftHip] != null &&
        pose.landmarks[PoseLandmarkType.leftKnee] != null &&
        pose.landmarks[PoseLandmarkType.leftAnkle] != null) {
      angles.add(_calculateAngle(
          pose.landmarks[PoseLandmarkType.leftHip]!,
          pose.landmarks[PoseLandmarkType.leftKnee]!,
          pose.landmarks[PoseLandmarkType.leftAnkle]!));
    } else {
      angles.add(double.nan); // or some default value
      print("Left leg landmarks not detected.");
    }

    // Calculate angle for right hip, knee, and ankle
    if (pose.landmarks[PoseLandmarkType.rightHip] != null &&
        pose.landmarks[PoseLandmarkType.rightKnee] != null &&
        pose.landmarks[PoseLandmarkType.rightAnkle] != null) {
      angles.add(_calculateAngle(
          pose.landmarks[PoseLandmarkType.rightHip]!,
          pose.landmarks[PoseLandmarkType.rightKnee]!,
          pose.landmarks[PoseLandmarkType.rightAnkle]!));
    } else {
      angles.add(double.nan); // or some default value
      print("Right leg landmarks not detected.");
    }

    return angles;
  }


  double _calculateAngle(PoseLandmark pointA, PoseLandmark pointB, PoseLandmark pointC) {
    final dx1 = pointA.x - pointB.x;
    final dy1 = pointA.y - pointB.y;
    final dx2 = pointC.x - pointB.x;
    final dy2 = pointC.y - pointB.y;
    final angleRadians = atan2(dy1, dx1) - atan2(dy2, dx2);
    final angleDegrees = (angleRadians * 180 / pi).abs();
    return angleDegrees > 180 ? 360 - angleDegrees : angleDegrees;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pose Detection")),
      body: Screenshot(
        controller: _screenshotController,
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Angles: $_angles");
        },
        child: Icon(Icons.calculate),
      ),
    );
  }
}
