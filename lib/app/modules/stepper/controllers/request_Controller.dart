import 'dart:convert';
import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:firstgetxapp/app/models/subscriber_model.dart';
import 'package:firstgetxapp/app/modules/stepper/controllers/stepper_controller.dart';
import 'package:firstgetxapp/app/modules/subscriber/controller/subscriber_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RequestController extends GetxController {
  // Controllers
  final StepperController stepperController = Get.find<StepperController>();
  final SubscriberController subscriberController = Get.find<SubscriberController>();

  final url = Uri.parse('${ApiConfig.baseUrl}/achate');

  Future<void> sendUserData() async {
    final subscriber = subscriberController.subscriber.value;

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'subscriber_id': subscriberId,
          'first_name': firstName,
          'last_name': lastName,
          'issued_by': issuedBy,
          'expiry_date': expiryDate,
          'document_number': documentNumber,
          'birth_date': birthDate,
          'nationality': nationality,
          'issue_date': issueDate,
          'gender': gender,
          'profile_type': stepperController.selectedCardIndex.value, 
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Data sent successfully!");
      } else {
        print("❌ Server error: ${response.statusCode}");
        print("Body: ${response.body}");
      }
    } catch (e) {
      print('⚠️ Exception: $e');
    }
  }
}
