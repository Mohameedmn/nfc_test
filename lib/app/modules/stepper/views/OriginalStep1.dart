import 'package:firstgetxapp/app/widgets/StepProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stepper_controller.dart';
import 'package:firstgetxapp/app/widgets/step_content_widget.dart';

class Originalstep1 extends GetView<StepperController> {
  const Originalstep1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                StepperAppBar(
                  steptitle: 'Step 1 of 3',
                  currentStep: 1.obs,
                  totalSteps: 3,
                ),
                const SizedBox(height: 30),
                StepContentWidget(
                  imagePath: 'assets/lottie/nfc_scan.json',
                  isLottie: true,
                  title: 'Scan Your CNI',
                  description:
                  'Please scan your National Identity Card. Make sure it s clear and all corners are visible.',
                  buttonText: 'Scan CNI',
                  onPressed: () {
                    Get.toNamed('/step1');

                  },
                ),
              ],
            ),
          )),
    );
  }
}
