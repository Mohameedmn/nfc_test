import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:firstgetxapp/app/modules/selfie/controllers/selfie_faceID.dart';
import 'package:firstgetxapp/app/modules/stepper/controllers/stepper_controller.dart';
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



  Future<void> sendImageAndVideo() async {
    //final uri = Uri.parse('http://172.20.10.2:5000/verify');

    final uri = Uri.parse(ApiConfig.face_id_url);

    try {
      Uint8List? faceImage = _stepperController.faceImage.value;
      if (faceImage == null) {
        print("❌ No face image to upload");
        return;
      }

      XFile? video = _selfieController.recordedVideo.value;

if (video == null) {
  print("❌ No recorded video found");
  return;
}

File videoFile = File(video.path);

      var request = http.MultipartRequest('POST', uri);

      // Add face image from bytes
      request.files.add(
        http.MultipartFile.fromBytes(
          'photo_nfc', 
          faceImage,
          filename: 'photo_nfc.jpg',  // Important to give a filename and extension
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      // Add video from file path
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
        // go to step

        Get.toNamed('/succes');
      } else {
        print("❌ Failed with status: ${response.statusCode}");

        Get.toNamed('/failure');
      }
    } catch (e) {
      print("⚠️ Error: $e");
    }
  }

  // Same helper method from your example to copy video asset to file
  Future<File> getAssetFile(String assetPath, String filename) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$filename');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Face ID Upload")),
      body: Center(
        child: ElevatedButton(
          onPressed: sendImageAndVideo,
          child: const Text("Send NFC Image & Video"),
        ),
      ),
    );
  }
}
