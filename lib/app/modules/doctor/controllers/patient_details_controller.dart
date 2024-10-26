import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/data/models/activity.dart';
import 'package:physiotherapy_body_detection/app/data/models/report.dart';

import '../../../user_controller.dart';

class PatientDetailsController extends GetxController {

  var reports = <Report>[].obs;
  var currentActivity = Get.find<UserController>().user.value?.currentActivity;

  @override
  void onInit() {
    super.onInit();
    fetchPatientDetails();
  }

  Future<void> fetchPatientDetails() async {
    // get patient details
  }
}
