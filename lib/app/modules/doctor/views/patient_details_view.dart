import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/data/models/patient.dart';
import '../controllers/patient_details_controller.dart';

class PatientDetailsView extends GetView<PatientDetailsController> {
  const PatientDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = Get.arguments as Patient;
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
                      '${patient.firstName} ${patient.lastName}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      patient.email,
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
                      ),
                      elevation: 8,
                      color: Colors.grey[300],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: controller.currentActivity.value.name.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange[900],
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  controller.currentActivity.value.name,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[900],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${controller.currentActivity.value.duration}min - ${controller.currentActivity.value.startingTime} - ${controller.currentActivity.value.period} days',
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
                        fixedSize: WidgetStatePropertyAll(Size(screenWidth * 0.5, 50)),
                        backgroundColor: WidgetStatePropertyAll(Colors.orange[900]),
                        foregroundColor: WidgetStatePropertyAll(Colors.grey[200]),
                        elevation: const WidgetStatePropertyAll(4),
                      ),
                      onPressed: () {
                        controller.changeActivity();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.change_circle_outlined),
                          SizedBox(width: 6),
                          Text(
                            'CHANGE',
                            style: TextStyle(
                              fontSize: 18,
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
                  return const SizedBox.shrink();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Report:',
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