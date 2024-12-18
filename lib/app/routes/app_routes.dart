part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const AUTH_LOGIN = _Paths.AUTH_LOGIN;
  static const AUTH_REGISTER = _Paths.AUTH_REGISTER;
  static const DOCTOR = _Paths.DOCTOR;
  static const PATIENT = _Paths.PATIENT;
  static const MY_PATIENTS = _Paths.DOCTOR + _Paths.MY_PATIENTS;
  static const PATIENT_DETAILS = _Paths.DOCTOR + _Paths.PATIENT_DETAILS;
  static const NEW_ACTIVITY = _Paths.DOCTOR + _Paths.NEW_ACTIVITY;
  static const PROFILE = _Paths.PATIENT + _Paths.PROFILE;
  static const CAMERA = _Paths.PATIENT + _Paths.CAMERA;
  static const HOME = _Paths.PATIENT + _Paths.HOME;
  static const DEV = _Paths.DEV;
}

abstract class _Paths {
  _Paths._();
  static const AUTH_LOGIN = '/login';
  static const AUTH_REGISTER = '/register';
  static const DOCTOR = '/doctor';
  static const PATIENT = '/patient';
  static const MY_PATIENTS = '/my-patients';
  static const PATIENT_DETAILS = '/patient-details';
  static const NEW_ACTIVITY = '/new-activity';
  static const PROFILE = '/profile';
  static const CAMERA = '/camera';
  static const HOME = '/home';
  static const DEV = '/dev';
}
