import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/components/text_input_field.dart';

import '../controllers/new_activity_controller.dart';

class NewActivityView extends GetView<NewActivityController> {
  const NewActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardHeight = screenHeight * 0.3;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              Center(
                child: Text(
                  'Assign new activity',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: cardHeight,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange[900],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: controller.exercises.length,
                        itemBuilder: (context, index) {
                          final exercise = controller.exercises[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange[900],
                              child: Text(
                                exercise.name[0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              exercise.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                            trailing: Obx(() {
                              return Icon(
                                controller.checkedExercise.value?.id == exercise.id
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank,
                                color: Colors.grey[900],
                              );
                            }),
                            onTap: () {
                              controller.setExercise(exercise);
                            },
                            splashColor: Colors.transparent,
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 70,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextInputField(
                      textColor: Colors.grey[400]!,
                      color: Colors.grey[900]!,
                      controller: controller.durationController,
                      labelText: 'Duration',
                      hintText: 'Duration...',
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: 70,
                    child: Text(
                      'min',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextInputField(
                      textColor: Colors.grey[400]!,
                      color: Colors.grey[900]!,
                      controller: controller.startingTimeController,
                      labelText: 'Starting time',
                      hintText: 'Starting time...',
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: 70,
                    child: Text(
                      'hour',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextInputField(
                      textColor: Colors.grey[400]!,
                      color: Colors.grey[900]!,
                      controller: controller.periodController,
                      labelText: 'Period',
                      hintText: 'Period...',
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: 70,
                    child: Text(
                      'days',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40,),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(screenWidth * 0.5, 50)),
                  backgroundColor: WidgetStatePropertyAll(Colors.orange[900]),
                  foregroundColor: WidgetStatePropertyAll(Colors.grey[200]),
                  elevation: const WidgetStatePropertyAll(4),
                ),
                onPressed: () {
                  controller.assignNewActivity();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_download_done_rounded),
                    SizedBox(width: 6),
                    Text(
                      'ASSIGN',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,)
            ]
          )
        )
      )
    );
  }
}
