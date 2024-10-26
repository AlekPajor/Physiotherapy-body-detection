import 'package:get/get.dart';

import '../modules/auth/bindings/auth_login_binding.dart';
import '../modules/auth/bindings/auth_register_binding.dart';
import '../modules/auth/views/auth_login_view.dart';
import '../modules/auth/views/auth_register_view.dart';
import '../modules/dev/bindings/dev_binding.dart';
import '../modules/dev/views/dev_view.dart';
import '../modules/doctor/bindings/my_patients_binding.dart';
import '../modules/doctor/bindings/new_activity_binding.dart';
import '../modules/doctor/bindings/patient_details_binding.dart';
import '../modules/doctor/views/my_patients_view.dart';
import '../modules/doctor/views/new_activity_view.dart';
import '../modules/doctor/views/patient_details_view.dart';
import '../modules/patient/bindings/camera_binding.dart';
import '../modules/patient/bindings/home_binding.dart';
import '../modules/patient/bindings/profile_binding.dart';
import '../modules/patient/views/camera_view.dart';
import '../modules/patient/views/home_view.dart';
import '../modules/patient/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH_LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.AUTH_LOGIN,
      page: () => const AuthLoginView(),
      binding: AuthLoginBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_REGISTER,
      page: () => const AuthRegisterView(),
      binding: AuthRegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MY_PATIENTS,
      page: () => const MyPatientsView(),
      binding: MyPatientsBinding(),
    ),
    GetPage(
      name: Routes.PATIENT_DETAILS,
      page: () => const PatientDetailsView(),
      binding: PatientDetailsBinding(),
    ),
    GetPage(
      name: _Paths.NEW_ACTIVITY,
      page: () => const NewActivityView(),
      binding: NewActivityBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA,
      page: () => const CameraView(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: _Paths.DEV,
      page: () => PoseDetectionVideoScreen(videoPath: 'assets/anterior_body_extension.mp4',),
      binding: DevBinding(),
    ),
  ];
}
