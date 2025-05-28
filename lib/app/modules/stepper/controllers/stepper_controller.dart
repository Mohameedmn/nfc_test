// controllers/stepper_controller.dart
import 'package:get/get.dart';

class StepperController extends GetxController {
  var currentStep = 1.obs; // Track current step

  void goToNextStep(int step) {
    if (step == 1) {
      currentStep.value = 2; // Move to step 2
      Get.offNamed('/step2'); // Navigate to step 2
    } else if (step == 2) {
      currentStep.value = 3; // Move to step 3
      Get.offNamed('/step3'); // Navigate to step 3
    }
  }

  void updateStepFromRoute(String route) {
    if (route == '/step1') {
      currentStep.value = 1;
    } else if (route == '/step2') {
      currentStep.value = 2;
    } else if (route == '/step3') {
      currentStep.value = 3;
    }
  }


  // step1 
   var selectedCardIndex = (1).obs;

  // You can also add a method to reset or handle selection if you want
  void selectCard(int index) {
    selectedCardIndex.value = index;
  }
}
