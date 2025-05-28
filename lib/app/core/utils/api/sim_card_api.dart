import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class SimCardApi {
  static Future<List<dynamic>> getAvailableSimCards() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/sim-cards');

    final response = await http.get(
      url,
      headers: await ApiConfig.getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    print('Failed to load SIM cards: ${response.body}');
    return [];
  }
}
