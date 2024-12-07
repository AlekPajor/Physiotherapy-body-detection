import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

import '../../../../../main.dart';
import '../modules/patient/controllers/camera_controller.dart';

class PoseDetectionWidget extends StatefulWidget {
  const PoseDetectionWidget(
      {super.key,
        required this.title,
        required this.customPaint,
        this.text,
        required this.onImage,
        this.initialDirection = CameraLensDirection.back,
        required this.cameraScreenController});

  final String title;
  final CustomPaint? customPaint;
  final String? text;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;
  final CameraScreenController cameraScreenController;

  @override
  _PoseDetectionWidgetState createState() => _PoseDetectionWidgetState();
}

class _PoseDetectionWidgetState extends State<PoseDetectionWidget> {
  bool showCustomDialog = true;
  bool countdownStarted = false;
  int countdown = 0;
  CameraController? cameraController;
  bool liveFeedStarted = false;
  num cameraIndex = 0;
  bool changingCameraLens = false;

  @override
  void initState() {
    super.initState();

    if (cameras.any((element) =>
      element.lensDirection == widget.initialDirection && element.sensorOrientation == 90,
    )) {
      cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
          element.lensDirection == widget.initialDirection && element.sensorOrientation == 90
        ),
      );
    } else {
      cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
          element.lensDirection == widget.initialDirection
        ),
      );
    }
    startLiveFeed();
  }

  @override
  void dispose() {
    stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: cameras.length == 1
      ? null
      : SizedBox(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
            backgroundColor: Colors.grey[900],
            onPressed: switchLiveCamera,
            child: Icon(
              Platform.isIOS
                  ? Icons.flip_camera_ios_outlined
                  : Icons.flip_camera_android_outlined,
              size: 40,
              color: Colors.orange[900],
            ),
          )
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        fit: StackFit.expand,
        children: [
          (cameraController == null || !cameraController!.value.isInitialized || !liveFeedStarted)
          ? Container(
              color: Colors.grey[900],
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange[900],
                ),
              ),
            )
          : Obx(() {
            final size = MediaQuery.of(context).size;
            var scale = size.aspectRatio * cameraController!.value.aspectRatio;

            if (scale < 1) scale = 1 / scale;

            return Container(
              color: Colors.black,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Transform.scale(
                    scale: scale,
                    child: Center(
                      child: changingCameraLens
                      ? Center(
                        child: Text(
                          'Changing camera lens',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      )
                      : CameraPreview(cameraController!),
                    ),
                  ),
                  if (widget.cameraScreenController.customPaint.value != null)
                    widget.cameraScreenController.customPaint.value!,
                ],
              ),
            );
          }),
          if (showCustomDialog) IgnorePointer(
            ignoring: false,
            child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.8,
                  child: Container(color: Colors.black),
                ),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: widget.cameraScreenController.currentActivity.value != null
                    ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!countdownStarted) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Start your activity',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.cameraScreenController.currentActivity.value!.exercise.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${widget.cameraScreenController.currentActivity.value!.duration}min - ${widget.cameraScreenController.currentActivity.value!.startingTime} - ${widget.cameraScreenController.currentActivity.value!.period} days',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.orange[900]),
                              foregroundColor: WidgetStatePropertyAll(Colors.grey[400]),
                            ),
                            onPressed: () {
                              startCountdown();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                'Start',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ] else ...[
                          Text(
                            'Starting in $countdown',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                          ),
                        ],
                      ],
                    )
                    : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 280,
                          child: Center(
                            child: Text(
                              "No activity assigned",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (widget.cameraScreenController.activityEnded.value) {
              return IgnorePointer(
                ignoring: false,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.8,
                        child: Container(color: Colors.black),
                      ),
                    ),
                    Center(
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  'Activity finished 🎉',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Correctness: ${widget.cameraScreenController.correctness!}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(Colors.orange[900]),
                                  foregroundColor: WidgetStatePropertyAll(Colors.grey[400]),
                                ),
                                onPressed: () {
                                  widget.cameraScreenController.setActivityEnded(false);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    )
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  void startCountdown() {
    setState(() {
      countdown = 5;
      countdownStarted = true;
    });

    Future.doWhile(() async {
      if (countdown > 0) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          countdown--;
        });
        return true;
      } else {
        setState(() {
          showCustomDialog = false;
        });
        widget.cameraScreenController.startActivity();
        return false;
      }
    });

  }

  Future startLiveFeed() async {
    var cameras = await availableCameras();
    final camera = cameras[cameraIndex.toInt()];
    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      cameraController?.startImageStream(processCameraImage);
      setState(() {});
    });
    liveFeedStarted = true;
  }

  Future stopLiveFeed() async {
    await cameraController?.stopImageStream();
    await cameraController?.dispose();
    cameraController = null;
  }

  Future switchLiveCamera() async {
    setState(() => changingCameraLens = true);
    cameraIndex = (cameraIndex + 1) % cameras.length;

    await stopLiveFeed();
    await startLiveFeed();
    setState(() => changingCameraLens = false);
  }

  Future processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[cameraIndex.toInt()];
    final imageRotation =
    InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
    InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage = InputImage.fromBytes(
        bytes: bytes,
        inputImageData: inputImageData
    );

    widget.cameraScreenController.setCurrentImage(inputImage);
    await widget.cameraScreenController.processImage(inputImage);
  }
}
