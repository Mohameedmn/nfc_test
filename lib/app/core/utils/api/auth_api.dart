import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class AuthApi {
  /// Logs in a user using email and password.
  static Future<bool> login(String phoneNumber, String password) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/login');


    final response = await http.post(
      url,
      headers: await ApiConfig.getHeaders(withAuth: false),
      body: jsonEncode({
        'phone_number': phoneNumber,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('token')) {
        await ApiConfig.storage.write(key: 'token', value: data['token']);
        return true;
      }
    }

    print('Login failed: ${response.body}');
    return false;
  }

  /// Logs out the current user by deleting the token.
  static Future<void> logout() async {
  final url = Uri.parse('${ApiConfig.baseUrl}/logout');

  try {
    final response = await http.post(
      url,
      headers: await ApiConfig.getHeaders(), // Includes the Bearer token
    );

    if (response.statusCode == 200) {
      print('Logged out successfully from server');
    } else {
      print('Server logout failed: ${response.body}');
    }
  } catch (e) {
    print('Error calling logout: $e');
  }

  // Remove token from secure storage in any case
  await ApiConfig.storage.delete(key: 'token');
}



  /// Registers a new user with the given fields.
  static Future<bool> register({
    required String phone_number,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/register');

    final response = await http.post(
      url,
      headers: await ApiConfig.getHeaders(withAuth: false),
      body: jsonEncode({
        'phone_number': phone_number,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('token')) {
        await ApiConfig.storage.write(key: 'token', value: data['token']);
        return true;
      }
    }

    print('Registration failed: ${response.body}');
    return false;
  }
}
