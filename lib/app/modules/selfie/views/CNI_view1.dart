// lib/app/modules/back_camera/back_camera_view.dart
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/selfie_CNI_controller.dart';
class CniView1 extends GetView<SelfieCNIController> {
  const CniView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Take a Photo")),
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: AspectRatio(
                  aspectRatio: controller.cameraController.value.aspectRatio,
                  child: CameraPreview(controller.cameraController),
                ),
              ),
              const SizedBox(height: 20),
              
              // Capture photo button
              ElevatedButton(
                onPressed: controller.takePicture,
                child: const Text("📸 Take Photo"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next step
                  Get.toNamed('/step2'); // Adjust the route as needed
                },
                child: const Text("next step"),
              ),

              
              // Display captured image
              Obx(() {
                final image = controller.capturedImage.value;
                return image != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(File(image.path)),
                      )
                    : const SizedBox();
              }),
            ],
          ),
        );
      }),
    );
  }
}