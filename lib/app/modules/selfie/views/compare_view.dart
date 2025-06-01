import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:firstgetxapp/app/modules/selfie/controllers/selfie_faceID.dart';
import 'package:firstgetxapp/app/modules/stepper/controllers/stepper_controller.dart';
import 'package:firstgetxapp/app/modules/stepper/controllers/nfcscanne_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class UploadScreen extends StatelessWidget {
  UploadScreen({super.key});

  final StepperController _stepperController = Get.find<StepperController>();
  final SelfieFaceIDController _selfieController = Get.find<SelfieFaceIDController>();
  final NfcScanneController _nfcController = Get.find<NfcScanneController>();

  Future<void> sendImageAndVideo() async {
    final uri = Uri.parse(ApiConfig.face_id_url);

    try {
      Uint8List? faceImage = _nfcController.faceImage.value;

      if (faceImage == null) {
        print("❌ No NFC image available");
        return;
      }

      XFile? video = _selfieController.recordedVideo.value;
      if (video == null) {
        print("❌ No recorded video found");
        return;
      }

      File videoFile = File(video.path);
      var request = http.MultipartRequest('POST', uri);

      // Add face image from NFC
      request.files.add(
        http.MultipartFile.fromBytes(
          'photo_nfc',
          faceImage,
          filename: 'photo_nfc.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      // Add content type header
      request.headers['Content-Type'] = 'multipart/form-data';

      // Add video from recorded file
      request.files.add(
        await http.MultipartFile.fromPath(
          'video_face',
          videoFile.path,
          contentType: MediaType('video', 'mp4'),
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        print("✅ Success: $respStr");
        Get.toNamed('/succes');
      } else {
        print("❌ Failed with status: ${response.statusCode}");
        Get.toNamed('/failure');
      }
    } catch (e) {
      print("⚠️ Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Face ID Upload")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final image = _nfcController.faceImage.value;
              if (image != null) {
                return Image.memory(image, width: 200, height: 200, fit: BoxFit.cover);
              } else {
                return const Text("No NFC face image available.");
              }
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendImageAndVideo,
              child: const Text("Send NFC Image & Video"),
            ),
          ],
        ),
      ),
    );
  }
}
