import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class OfferApi {
  static Future<List<dynamic>?> getOffers() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/offers');
    final headers = await ApiConfig.getHeaders();

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error fetching offers: ${response.statusCode}');
      return null;
    }
  }
}
