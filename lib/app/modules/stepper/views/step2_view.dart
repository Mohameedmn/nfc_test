import 'package:firstgetxapp/app/widgets/StepProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stepper_controller.dart';
import 'package:firstgetxapp/app/widgets/step_content_widget.dart';

class Step2View extends GetView<StepperController> {
  const Step2View({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.updateStepFromRoute('/step3'); // Ensure the step is updated

    return Scaffold(
      body: Center(
          child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            StepperAppBar(
              steptitle: 'Step 2 of 3',
              currentStep: 2.obs,
              totalSteps: 3,
            ),
            const SizedBox(height: 30),
            StepContentWidget(
              imagePath: 'assets/lottie/face_id.json',
              isLottie: true, 
              title: "Take a Video Selfie",
              description:
                  'For security purposes, we need you to take a quick selfie.',
              buttonText: 'Take a Video Selfie',
              onPressed: () {
                Get.toNamed('/selfie-FACEID');
              },
            ),
          ],
        ),
      )),
    );
  }
}