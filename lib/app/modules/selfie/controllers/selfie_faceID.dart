import 'package:camera/camera.dart';
import 'package:get/get.dart';

class SelfieFaceIDController extends GetxController {
  late CameraController cameraController;
  var isCameraInitialized = false.obs;
  var isRecording = false.obs;
  var recordedVideo = Rxn<XFile>();

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => throw Exception('Front camera not found'),
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: true,
      );

      await cameraController.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      print('Camera initialization failed: $e');
    }
  }

  Future<void> startRecording() async {
    if (!isCameraInitialized.value) return;

    try {
      if (!cameraController.value.isRecordingVideo) {
        await cameraController.startVideoRecording();
        isRecording.value = true;

        // Automatically stop after 5 seconds
        Future.delayed(const Duration(seconds: 5), () async {
          await stopRecording();
        });
      }
    } catch (e) {
      print('Start recording failed: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      if (cameraController.value.isRecordingVideo) {
        final video = await cameraController.stopVideoRecording();
        recordedVideo.value = video;
        isRecording.value = false;
      }
    } catch (e) {
      print('Stop recording failed: $e');
    }
  }

  @override
  void onClose() {
    if (cameraController.value.isInitialized) {
      cameraController.dispose();
    }
    super.onClose();
  }
}