import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SelfieCNIController extends GetxController {
  late CameraController cameraController;
  var isCameraInitialized = false.obs;
  var capturedImage = Rxn<XFile>();

  static const platform = MethodChannel('com.example.nfcreaderapp/passport_reader');

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => throw Exception('Back camera not found'),
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

  /// Calls the native Android function to scan MRZ via method channel
  Future<String?> scanMrz() async {
    try {
      final result = await platform.invokeMethod<String>('scanMrz');
      return result;
    } on PlatformException catch (e) {
      print('Failed to scan MRZ: ${e.message}');
      return null;
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
