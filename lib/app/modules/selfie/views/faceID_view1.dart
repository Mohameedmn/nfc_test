import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/selfie_faceID.dart';
class SelfieView1 extends GetView<SelfieFaceIDController> {
  const SelfieView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Record a Selfie Video")),
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
              
              // Record button
              ElevatedButton(
                onPressed: controller.isRecording.value
                    ? controller.stopRecording
                    : controller.startRecording,
                child: Obx(() => Text(controller.isRecording.value ? "⏹️ Stop Recording" : "🎥 Start Recording")),
              ),
              
            const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next step
                  Get.toNamed('/step3'); // Adjust the route as needed
                },
                child: const Text("next step"),
              ),
              const SizedBox(height: 20),
              
              // Show recorded video file path (or you can implement video preview later)
              Obx(() {
                final video = controller.recordedVideo.value;
                return video != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Video saved at:\n${video.path}'),
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
