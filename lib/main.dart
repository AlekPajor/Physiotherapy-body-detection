import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
