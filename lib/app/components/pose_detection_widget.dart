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
  bool liveFeedStarted = false;
  CameraController? _controller;
  num _cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  bool _changingCameraLens = false;
  bool _showCustomDialog = true;
  int _countdown = 0;  // For the countdown
  bool _countdownStarted = false;

  @override
  void initState() {
    super.initState();

    if (cameras.any((element) =>
    element.lensDirection == widget.initialDirection && element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
        element.lensDirection == widget.initialDirection &&
            element.sensorOrientation == 90),
      );
    } else {
      _cameraIndex = cameras.indexOf(cameras.firstWhere(
              (element) => element.lensDirection == widget.initialDirection),
      );
    }

    _startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _liveFeedBody(),
          if (_showCustomDialog) _buildDialog(context),
        ],
      ),
    );
  }

  Widget? _floatingActionButton() {
    if (cameras.length == 1) return null;
    return SizedBox(
        height: 50.0,
        width: 50.0,
        child: FloatingActionButton(
          backgroundColor: Colors.grey[900],
          onPressed: _switchLiveCamera,
          child: Icon(
            Platform.isIOS
                ? Icons.flip_camera_ios_outlined
                : Icons.flip_camera_android_outlined,
            size: 40,
            color: Colors.orange[900],
          ),
        )
    );
  }


  Widget _liveFeedBody() {
    if (_controller == null || !_controller!.value.isInitialized || !liveFeedStarted) {
      return Container(
        color: Colors.grey[900],
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.orange[900],
          ),
        ),
      );
    }

    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * _controller!.value.aspectRatio;

    if (scale < 1) scale = 1 / scale;

    return Obx(() => Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Transform.scale(
            scale: scale,
            child: Center(
              child: _changingCameraLens
                ? Center(
                    child: Text(
                      'Changing camera lens',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  )
                : CameraPreview(_controller!),
            ),
          ),
          if (widget.cameraScreenController.customPaint.value != null)
            widget.cameraScreenController.customPaint.value!,
        ],
      ),
    ));
  }

  Widget _buildDialog(BuildContext context) {
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
                  if (!_countdownStarted) ...[
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
                          widget.cameraScreenController.currentActivity.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${widget.cameraScreenController.currentActivity.duration}min - ${widget.cameraScreenController.currentActivity.startingTime} - ${widget.cameraScreenController.currentActivity.period} days',
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
                        _startCountdown();
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
                      'Starting in $_countdown',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startCountdown() {
    setState(() {
      _countdown = 5;
      _countdownStarted = true;
    });

    Future.doWhile(() async {
      if (_countdown > 0) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _countdown--;
        });
        return true;
      } else {
        setState(() {
          _showCustomDialog = false;
        });
        return false;
      }
    });
  }

  Future _startLiveFeed() async {
    var cameras = await availableCameras();
    final camera = cameras[_cameraIndex.toInt()];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
    liveFeedStarted = true;
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex.toInt()];
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

    await widget.cameraScreenController.processImage(inputImage);
  }
}
