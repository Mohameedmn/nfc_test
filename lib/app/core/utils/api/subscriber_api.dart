import 'dart:convert';
import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:firstgetxapp/app/models/identitydocument_model.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> getCurrentSubscriber() async {
  final url = Uri.parse('${ApiConfig.baseUrl}/subscriber/currentSubscriber');
  final headers = await ApiConfig.getHeaders();

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('Error fetching subscriber: ${response.statusCode}');
    return null;
  }
}

Future<IdentityDocument?> fetchIdentityDocument() async {
  final url = Uri.parse('${ApiConfig.baseUrl}/subscriber/identity-document');
  final token = await ApiConfig.getToken();

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return IdentityDocument.fromJson(data);
    }
  } catch (e) {
    print('Error fetching identity document: $e');
  }

  return null;
}

