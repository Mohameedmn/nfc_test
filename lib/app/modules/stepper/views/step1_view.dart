import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stepper_controller.dart';
import 'package:firstgetxapp/app/widgets/step_content_widget.dart';

class Step1View extends GetView<StepperController> {
  const Step1View({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // Use the StepperAppBar widget here to display the progress bar
      appBar: AppBar(),
      body: Center(
        child: StepContentWidget(
          imagePath: 'assets/images/step2.png',
          title: 'Scan Your CNI',
          description:
              'Please scan your National Identity Card. Make sure it s clear and all corners are visible.',
          buttonText: 'Scan CNI',
          onPressed: () {
            Get.toNamed('/selfie-CNI'); 
            
          },
        ),
      ),
    );
  }
}
