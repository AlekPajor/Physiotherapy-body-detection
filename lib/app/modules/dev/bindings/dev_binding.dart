import 'package:get/get.dart';

import '../controllers/dev_controller.dart';

class DevBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DevController>(
      () => DevController(),
    );
  }
}
