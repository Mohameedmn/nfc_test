import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class PurchaseRequestApi {
  static Future<bool> createRequest(Map<String, dynamic> data) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/subscriber/purchase-requests');

    final response = await http.post(
      url,
      headers: await ApiConfig.getHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return true;
    }

    print('Create request failed: ${response.body}');
    return false;
  }

  static Future<List<dynamic>> getMyRequests() async {
  final url = Uri.parse('${ApiConfig.baseUrl}/subscriber/purchase-requests');
  final response = await http.get(url, headers: await ApiConfig.getHeaders());

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);

    // If the API returns an object with a 'data' field
    if (body is Map && body.containsKey('data')) {
      return body['data'];
    }

    // Otherwise, assume it’s a list directly
    return body;
  }

  return [];
}

}
