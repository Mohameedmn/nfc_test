// controllers/stepper_controller.dart
import 'dart:typed_data';

import 'package:firstgetxapp/app/modules/native/nativecontroller.dart';
import 'package:get/get.dart';

class StepperController extends GetxController {
  var currentStep = 1.obs; // Track current step

  final NativePassportReaderService _native = NativePassportReaderService();

  var statusMessage = 'Scan result will appear here'.obs;
  var isReadingNfc = false.obs;
  var nfcData = <String, dynamic>{}.obs;
  var faceImage = Rxn<Uint8List>();

  String? documentNumber;
  String? dateOfBirth;
  String? expirationDate;

  Future<void> startMRZScan() async {
    statusMessage.value = "Starting MRZ scan...";
    faceImage.value = null;
    nfcData.clear();

    try {
      final result = await _native.startMRZScan();

      if (result != null) {
        documentNumber = result['documentNumber']?.toString();
        dateOfBirth = result['dateOfBirth']?.toString();
        expirationDate = result['expirationDate']?.toString();

        statusMessage.value = '''
          MRZ Read Successfully:
          Document Number: $documentNumber
          Date of Birth: $dateOfBirth
          Expiry Date: $expirationDate

          Now hold the passport to the back of your phone for NFC...
          ''';

        await startNfcRead();
      } else {
        statusMessage.value = "MRZ scan returned null or invalid data.";
      }
    } catch (e) {
      statusMessage.value = "Error during MRZ scan: $e";
    }
  }

  Future<void> startNfcRead() async {
    if (documentNumber == null || dateOfBirth == null || expirationDate == null) {
      statusMessage.value = "Missing MRZ data. Cannot start NFC read.";
      return;
    }

    isReadingNfc.value = true;
    statusMessage.value += "\n\n Reading NFC tag...";

    try {
      final result = await _native.readNfc(
        documentNumber: documentNumber!,
        dateOfBirth: dateOfBirth!,
        expirationDate: expirationDate!,
      );

      if (result != null) {
        var genderRaw = result['gender'];
        if (genderRaw != null && genderRaw is! String) {
          result['gender'] = genderRaw.toString().split('.').last;
        } else {
          result['gender'] ??= "N/A";
        }

        nfcData.assignAll(result);

        if (result['faceImage'] != null && result['faceImage'] is List<dynamic>) {
          final bytes = Uint8List.fromList(result['faceImage'].cast<int>());
          faceImage.value = bytes;
        }
      } else {
        statusMessage.value = "Unexpected NFC read result: null";
      }
    } catch (e) {
      statusMessage.value = "Error during NFC read: $e";
    } finally {
      isReadingNfc.value = false;
    }
  }

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








