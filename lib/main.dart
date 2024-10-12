import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'app/user_controller.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  Get.put(UserController());
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.quicksandTextTheme(),
      ),
      title: "Physiotherapy-body-detection",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
