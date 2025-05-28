import 'package:firstgetxapp/app/modules/selfie/controllers/compare_controller.dart';
import 'package:firstgetxapp/app/modules/selfie/controllers/selfie_CNI_controller.dart';
import 'package:firstgetxapp/app/modules/selfie/controllers/selfie_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompareView extends StatelessWidget {
  final FaceCompareController compareController = Get.put(FaceCompareController());
  final SelfieCNIController cniController = Get.find();
  final SelfieController faceIDController = Get.find();

   CompareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare Face and ID')),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (cniController.capturedImage.value != null)
                Text("Image: ${cniController.capturedImage.value!.name}"),
              if (faceIDController.capturedImage.value != null)
                Text("Video: ${faceIDController.capturedImage.value!.name}"),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: compareController.isLoading.value
                    ? null
                    : () async {
                        if (cniController.capturedImage.value == null ||
                            faceIDController.capturedImage.value == null) {
                          Get.snackbar("Missing", "Make sure both image and video are captured.");
                          return;
                        }
                        await compareController.compareVideoAndImage();
                      },
                child: compareController.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Compare"),
              ),

              const SizedBox(height: 24),

              if (compareController.matchResult.value != null)
                Text(
                  compareController.matchResult.value!
                      ? "Matched ✅"
                      : "Not Matched ❌",
                  style: TextStyle(
                    fontSize: 20,
                    color: compareController.matchResult.value! ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        );
      }),
    );
  }
}
