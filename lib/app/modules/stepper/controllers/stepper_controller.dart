import 'dart:typed_data';
import 'package:get/get.dart';

class StepperController extends GetxController {
  // Track current step
  var currentStep = 1.obs;

  // NFC data stored as observable Map
  var nfcData = <String, dynamic>{}.obs;

  // Face image stored as observable Uint8List?
  var faceImage = Rx<Uint8List?>(null);

  void goToNextStep(int step) {
    if (step == 1) {
      currentStep.value = 2;
      Get.offNamed('/step2');
    } else if (step == 2) {
      currentStep.value = 3;
      Get.offNamed('/step3');
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

  // step1 card selection (example)
  var selectedCardIndex = 1.obs;

  void selectCard(int index) {
    selectedCardIndex.value = index;
  }

  // Method to store NFC data and face image
  void setNfcData(Map<String, dynamic> data, Uint8List image) {
    nfcData.value = data;
    faceImage.value = image;
  }
}
