import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/routes/app_pages.dart';
import '../app/data/models/user.dart';

class UserController extends GetxController {
  var user = Rxn<User>();

  void setUser(User newUser) {
    user.value = newUser;
  }

  void clearUser() {
    user.value = null;
  }

  void logout() {
    clearUser();
    Get.offAllNamed(AppPages.INITIAL);
  }

  bool get isLoggedIn => user.value != null;
}
