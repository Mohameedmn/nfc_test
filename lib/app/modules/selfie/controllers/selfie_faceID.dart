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
  }

  Future<void> startRecording() async {
    if (!cameraController.value.isRecordingVideo) {
      await cameraController.startVideoRecording();
      isRecording.value = true;
    }
  }

  Future<void> stopRecording() async {
    if (cameraController.value.isRecordingVideo) {
      final video = await cameraController.stopVideoRecording();
      recordedVideo.value = video;
      isRecording.value = false;
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
