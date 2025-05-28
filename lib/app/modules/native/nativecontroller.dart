import 'package:flutter/services.dart';

class NativeController {
  static const MethodChannel _channel = MethodChannel('com.example.myapp/native');

  Future<String?> startMRZScan() async {
    try {
      final result = await _channel.invokeMethod<String>('startMRZScan');
      return result;
    } on PlatformException catch (e) {
      return 'Error: ${e.message}';
    }
  }

  Future<void> stopMRZScan() async {
    try {
      await _channel.invokeMethod('stopMRZScan');
    } on PlatformException catch (e) {
      print('Error stopping MRZ scan: ${e.message}');
    }
  }

  Future<String?> readNfc() async {
    try {
      final result = await _channel.invokeMethod<String>('readNFC');
      return result;
    } on PlatformException catch (e) {
      return 'Error: ${e.message}';
    }
  }
}
