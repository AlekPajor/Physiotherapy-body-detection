import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bindings/camera_binding.dart';
import '../bindings/profile_binding.dart';
import '../controllers/home_controller.dart';
import '../views/camera_view.dart';
import '../views/profile_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            ProfileBinding().dependencies();
            return const ProfileView();
          case 1:
            CameraBinding().dependencies();
            return const CameraView();
          default:
            ProfileBinding().dependencies();
            return const ProfileView();
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        selectedItemColor: Colors.orange[900],
        unselectedItemColor: Colors.grey[400],
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        iconSize: 26.0,
        backgroundColor: Colors.grey[900],
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
        ],
      )),
    );
  }
}
