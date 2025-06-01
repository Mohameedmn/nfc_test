import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:firstgetxapp/app/modules/selfie/controllers/selfie_faceID.dart';
import 'package:firstgetxapp/app/modules/stepper/controllers/stepper_controller.dart';
import 'package:firstgetxapp/app/modules/stepper/controllers/nfcscanne_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

class UploadScreen extends StatefulWidget {
  UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final StepperController _stepperController = Get.find<StepperController>();
  final SelfieFaceIDController _selfieController = Get.find<SelfieFaceIDController>();
  final NfcScanneController _nfcController = Get.find<NfcScanneController>();

  bool _isUploading = false;
  String? _uploadMessage;

  Future<void> saveDebugImage(Uint8List bytes) async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/debug_face_nfc.jpg');
      await file.writeAsBytes(bytes);
      print('✅ Debug NFC face image saved at: ${file.path}');
    } catch (e) {
      print('⚠️ Failed to save debug image: $e');
    }
  }

  Future<void> sendImageAndVideo() async {
    setState(() {
      _isUploading = true;
      _uploadMessage = null;
    });

    final uri = Uri.parse(ApiConfig.face_id_url);

    try {
      Uint8List? faceImage = _nfcController.faceImage.value;
      XFile? video = _selfieController.recordedVideo.value;

      if (faceImage == null) {
        setState(() {
          _uploadMessage = "❌ No NFC image available";
          _isUploading = false;
        });
        return;
      }

      if (video == null) {
        setState(() {
          _uploadMessage = "❌ No recorded video found";
          _isUploading = false;
        });
        return;
      }

      await saveDebugImage(faceImage); // Optional debug save

      File videoFile = File(video.path);
      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        http.MultipartFile.fromBytes(
          'photo_nfc',
          faceImage,
          filename: 'photo_nfc.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

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
        print("✅ Upload Success: $respStr");
        setState(() {
          _uploadMessage = "✅ Upload Success!";
          _isUploading = false;
        });
        Get.toNamed('/succes');
      } else {
        print("❌ Upload Failed with status: ${response.statusCode}");
        setState(() {
          _uploadMessage = "❌ Upload Failed: ${response.statusCode}";
          _isUploading = false;
        });
        Get.toNamed('/failure');
      }
    } catch (e) {
      print("⚠️ Upload Error: $e");
      setState(() {
        _uploadMessage = "⚠️ Upload Error: $e";
        _isUploading = false;
      });
      Get.toNamed('/failure');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Face ID Upload")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                final image = _nfcController.faceImage.value;
                if (image != null) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      image,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Erreur lors du chargement de l’image.');
                      },
                    ),
                  );
                } else {
                  return const Text(
                    "No NFC face image available.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  );
                }
              }),
              const SizedBox(height: 30),
              _isUploading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: sendImageAndVideo,
                      child: const Text("Send NFC Image & Video"),
                    ),
              const SizedBox(height: 20),
              if (_uploadMessage != null)
                Text(
                  _uploadMessage!,
                  style: TextStyle(
                    color: _uploadMessage!.startsWith("✅")
                        ? Colors.green
                        : (_uploadMessage!.startsWith("❌") ? Colors.red : Colors.orange),
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
