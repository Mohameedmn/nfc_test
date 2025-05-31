import 'dart:convert';
import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:firstgetxapp/app/modules/stepper/controllers/nfcscanne_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class RequestController extends GetxController {


  final nfcData = Get.find<NfcScanneController>().nfcData ?? {};
 // final Uri url = Uri.parse('http://192.168.1.71:8000/api/achate');

  final Uri url = Uri.parse('${ApiConfig.baseUrl}/achate');



  Future<void> sendUserData() async {
    final Map<String, dynamic> jsonData = {
      "subscriber_id": 1,
      'first_name': nfcData['primaryIdentifier'] ?? 'N/A',
      'last_name': nfcData['fullName'] ?? 'N/A',
      'issued_by': nfcData['placeOfBirth'] ?? 'N/A',
      'expiry_date': nfcData['dateOfExpiry'] ?? 'N/A',
      'document_number': nfcData['documentNumber'] ?? 'N/A',
      'birth_date': nfcData['dateOfBirth'] ?? 'N/A',
      'nationality': "Algerian",
      'issue_date': 'N/A',
      'gender': nfcData['gender'] ?? 'N/A',
      "profile_type": "Hayla"
    };

    /*
         body: jsonEncode({
          'subscriber_id': 100,
          'first_name': nfcData['primaryIdentifier'] ?? 'N/A',
          'last_name': nfcData['fullName'] ?? 'N/A',
          'issued_by': nfcData['placeOfBirth'] ?? 'N/A',
          'expiry_date': nfcData['dateOfExpiry'] ?? 'N/A',
          'document_number': nfcData['documentNumber'] ?? 'N/A',
          'birth_date': nfcData['dateOfBirth'] ?? 'N/A',
          'nationality': "Algerian",
          'issue_date':  'N/A',
          'gender': nfcData['gender'] ?? 'N/A',
          'profile_type': "Hayla",
        }),*/

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        print("✅ Success: ${response.body}");
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("⚠️ Exception: $e");
    }
  }
}
