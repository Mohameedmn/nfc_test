import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  // Helper to load asset and write it to a temporary file
  Future<File> getAssetFile(String assetPath, String filename) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$filename');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  Future<void> sendImageAndVideo() async {
    final uri = Uri.parse('http://192.168.1.71:5000/verify');

    try {
      // Copy image and video assets to temporary files
      final imageFile = await getAssetFile(
          'assets/images/test/phototest.jpg', 'phototest.jpg');
      final videoFile = await getAssetFile(
          'assets/images/test/videotest.mp4', 'videotest.mp4');

      // Create multipart request
      var request = http.MultipartRequest('POST', uri);

      // Add image
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo_nfc',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      // Add video
      request.files.add(
        await http.MultipartFile.fromPath(
          'video_face',
          videoFile.path,
          contentType: MediaType('video', 'mp4'),
        ),
      );

      // Send request
      var response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        print("✅ Success: $respStr");
      } else {
        print("❌ Failed with status: ${response.statusCode}");
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
        child: ElevatedButton(
          onPressed: sendImageAndVideo,
          child: const Text("Send Image & Video"),
        ),
      ),
    );
  }
}