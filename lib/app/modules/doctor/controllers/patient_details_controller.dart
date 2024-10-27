import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/data/models/activity.dart';
import 'package:physiotherapy_body_detection/app/data/models/report.dart';

import '../../../data/models/patient.dart';
import '../../../http_controller.dart';
import '../../../user_controller.dart';

class PatientDetailsController extends GetxController {
  final HttpController httpController = Get.put(HttpController());
  var reports = <Report>[].obs;
  var currentActivity = Rxn<Activity>();
  var isLoading = false.obs;
  var patient = Rxn<Patient>(null);

  @override
  void onInit() async {
    super.onInit();
    patient.value = Get.arguments as Patient;
    await fetchPatientDetails();
    currentActivity.value = patient.value!.currentActivity;
    await fetchPatientReports();
  }

  Future<void> fetchPatientReports() async {
    isLoading.value = true;
    try {
      reports.value = await httpController.fetchReportsByUserId(patient.value!.id!);
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPatientDetails() async {
    try {
      var fetchedPatient = await httpController.fetchPatientDetails(patient.value!.id!);
      patient.value = fetchedPatient;
      currentActivity.value = fetchedPatient.currentActivity;
    } catch (error) {
      print('Error: $error');
    }
  }
}
