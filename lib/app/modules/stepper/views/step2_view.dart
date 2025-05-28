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
      /* appBar: StepperAppBar(
        steptitle: 'Step 3 of 3',
        currentStep: controller.currentStep,
        totalSteps: 3, 
      ),*/
      body: Center(
        child: StepContentWidget(
          imagePath: 'assets/images/step3.png',
          title: "Take a Selfie",
          description:
              'For security purposes, we need you to take a quick selfie.',
          buttonText: 'Take Selfie',
          onPressed: () {
            Get.toNamed('/selfie-FACEID'); 
            
          },
        ),
      ),
    );
  }
}
