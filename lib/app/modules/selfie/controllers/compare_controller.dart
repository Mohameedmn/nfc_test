import 'dart:io';
import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:firstgetxapp/app/modules/selfie/controllers/selfie_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart'; // for extension
import './selfie_CNI_controller.dart';




class FaceCompareController extends GetxController {

  final url = Uri.parse('${ApiConfig.face_id_url}/verify');


  var isLoading = false.obs;
  var matchResult = RxnBool();

  final SelfieCNIController cniController = Get.find();
  final SelfieController faceIDController = Get.find();

  Future<void> compareVideoAndImage() async {
    isLoading.value = true;

    try {
      // Retrieve the image and video files from their respective controllers
      final imageFile = File(cniController.capturedImage.value!.path);
      final videoFile = File(faceIDController.capturedImage.value!.path);

      //final imageFile = File('assets/images/test/phototest.jpg');
      //final videoFile = File('assets/images/test/phototest.jpg');

      var request = http.MultipartRequest(
        'POST',
        url // pthon face id backend url
      );

      // Attach the video
      request.files.add(await http.MultipartFile.fromPath(
        'photo_live', // Field name for video on the server side
        imageFile.path,
        contentType: MediaType('image', extension(imageFile.path).replaceAll('.', '')),
      ));

      // Attach the image
      request.files.add(await http.MultipartFile.fromPath(
        'photo_nfc', // Field name for photo on the server side
        videoFile.path,
        contentType: MediaType('image', extension(videoFile.path).replaceAll('.', '')),
      ));

      // Send the request to the backend
      var response = await request.send();

      if (response.statusCode == 200) {
        final resp = await http.Response.fromStream(response);
        matchResult.value = resp.body.contains('true'); // Adapt based on your backend response
      } else {
        Get.snackbar("Error", "Server responded with status ${response.statusCode}");
        matchResult.value = null;
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
      matchResult.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
