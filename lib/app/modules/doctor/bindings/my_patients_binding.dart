import 'package:get/get.dart';

import '../controllers/my_patients_controller.dart';

class MyPatientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPatientsController>(
      () => MyPatientsController(),
    );
  }
}
