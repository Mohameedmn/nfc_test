// lib/app/modules/selfie/selfie_view.dart
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/selfie_controller.dart';

class SelfieView extends GetView<SelfieController> {
  const SelfieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Take a Selfie")),
      body: Obx(() {
        // Wait for the camera to initialize
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Camera preview
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6, // Take up 60% of the screen height
                child: AspectRatio(
                  aspectRatio: controller.cameraController.value.aspectRatio,
                  child: CameraPreview(controller.cameraController),
                ),
              ),
              
              // Spacer for button
              const SizedBox(height: 20),

              // Take selfie button
              ElevatedButton(
                onPressed: controller.takePicture,
                child: const Text("📸 Take Selfie"),
              ),
              
              // Spacer before the captured image
              const SizedBox(height: 20),

              // Display the captured selfie if available
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
