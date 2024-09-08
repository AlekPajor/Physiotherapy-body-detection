import 'package:get/get.dart';

import '../controllers/new_activity_controller.dart';

class NewActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewActivityController>(
      () => NewActivityController(),
    );
  }
}
