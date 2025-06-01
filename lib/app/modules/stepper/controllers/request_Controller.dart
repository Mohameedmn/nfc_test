import 'dart:convert';
import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:firstgetxapp/app/core/utils/api/subscriber_api.dart'
    as SubscriberApi;
import 'package:firstgetxapp/app/modules/stepper/controllers/nfcscanne_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RequestController extends GetxController {
  final NfcScanneController nfcScanneController = Get.put(NfcScanneController());
  final nfcData = Get.find<NfcScanneController>().nfcData ?? {};
  final Uri url = Uri.parse('${ApiConfig.baseUrl}/achate');

  /// This method fetches the current subscriber and sends NFC + subscriber data
  Future<void> sendUserData() async {
    try {
      // 1. Get current subscriber info
      final subscriber = await SubscriberApi.getCurrentSubscriber();
      if (subscriber == null || subscriber['id'] == null) {
        print("❌ Failed to get subscriber info");
        return;
      }

      // 2. Build JSON body with subscriber ID
      final Map<String, dynamic> jsonData = {
        "subscriber_id": subscriber['id'],
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

      // 3. Send the POST request
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
