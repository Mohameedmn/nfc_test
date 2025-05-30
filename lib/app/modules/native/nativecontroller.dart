import 'package:flutter/services.dart';

class NativePassportReaderService {
  static const MethodChannel _channel = MethodChannel('com.example.nfcreaderapp/passport_reader');

  Future<Map<String, dynamic>?> startMRZScan() async {
    final result = await _channel.invokeMethod('startMRZScan');
    if (result is Map) {
      return Map<String, dynamic>.from(result);
    }
    return null;
  }

  Future<Map<String, dynamic>?> readNfc({
    required String documentNumber,
    required String dateOfBirth,
    required String expirationDate,
  }) async {
    final result = await _channel.invokeMethod('readNfc', {
      'documentNumber': documentNumber,
      'dateOfBirth': dateOfBirth,
      'expirationDate': expirationDate,
    });
    if (result is Map) {
      return Map<String, dynamic>.from(result);
    }
    return null;
  }
}
