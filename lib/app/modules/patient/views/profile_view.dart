import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${controller.userController.user.value?.firstName} ${controller.userController.user.value?.lastName}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.userController.user.value!.email,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(() => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: Colors.orange[900]!,
                          width: 3,
                        ),
                      ),
                      elevation: 8,
                      color: Colors.grey[300],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              controller.currentActivity.value!.name,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[900],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${controller.currentActivity.value!.duration}min - ${controller.currentActivity.value!.startingTime} - ${controller.currentActivity.value!.period} days',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(screenWidth * 0.7, 50)),
                        backgroundColor: WidgetStatePropertyAll(Colors.orange[900]),
                        foregroundColor: WidgetStatePropertyAll(Colors.grey[200]),
                        elevation: const WidgetStatePropertyAll(4),
                      ),
                      onPressed: () {
                        controller.playVideo();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_circle_outlined),
                          SizedBox(width: 6),
                          Text(
                            'See instructional video' ,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Obx(() {
                if (controller.reports.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: 70,),
                      Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: Colors.orange[900],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your reports:',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.reports.length,
                        itemBuilder: (context, index) {
                          final report = controller.reports[index];
                          return Card(
                            color: Colors.grey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                '${report.activityName} - ${report.correctness}',
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                              subtitle: Text(
                                '${report.date} | ${report.time}',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              }),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
