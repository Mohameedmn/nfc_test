import 'package:camera/camera.dart';
import 'package:get/get.dart';

class SelfieController extends GetxController {
  late CameraController cameraController;
  var isCameraInitialized = false.obs;
  var capturedImage = Rxn<XFile>();

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => throw Exception('front camera not found'),
    );

    cameraController = CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize();
    isCameraInitialized.value = true;
  }

  Future<void> takePicture() async {
    if (!cameraController.value.isTakingPicture) {
      final picture = await cameraController.takePicture();
      capturedImage.value = picture;
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
