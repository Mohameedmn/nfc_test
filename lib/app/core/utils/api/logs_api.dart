import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class LogsApi {
  // Fetch logs for the current subscriber
  static Future<List<dynamic>> getMyLogs() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/subscriber/logs');
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

    print('Get logs failed: ${response.statusCode} ${response.body}');
    return [];
  }

    // Create a new log entry
  static Future<bool> createLog({
    required String action,
    required String actionType,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/subscriber/logs');

    final body = jsonEncode({
      'action': action,
      'action_type': actionType,
    });

    final response = await http.post(
      url,
      headers: await ApiConfig.getHeaders(),
      body: body,
    );

    if (response.statusCode == 201) {
      return true;
    }

    print('Create log failed: ${response.statusCode} ${response.body}');
    return false;
  }

}
