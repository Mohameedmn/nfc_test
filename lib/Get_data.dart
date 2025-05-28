import 'package:flutter/services.dart';

class GetData {
  static const platform = MethodChannel('com.example.nfcreaderapp/passport_reader');

  static Future<String> getDataFromJava() async {
    try {
      final int result = await platform.invokeMethod('GetDate');
      print("Result from Java: $result");
      return "Current timestamp: $result";
    } on PlatformException catch (e) {
      return "Error: ${e.message}";
    }
  }
}
