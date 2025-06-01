import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiConfig {
  static const String baseUrl = 'http://192.168.1.35:8000/api'; 
  static const String face_id_url ='http://192.168.1.35:5001/verify';
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<Map<String, String>> getHeaders({bool withAuth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (withAuth) {
      final token = await storage.read(key: 'token');
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  static Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  static Future<void> clearToken() async {
    await storage.delete(key: 'token');
  }

  static Future<String?> getToken() async {
  return await storage.read(key: 'token');
}

}
