import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'nfc_scanne.dart';  // Import the NFC scanner screen

class Step1View extends StatefulWidget {
  const Step1View({Key? key}) : super(key: key);

  @override
  State<Step1View> createState() => _Step1ViewState();
}

class _Step1ViewState extends State<Step1View> {
  static const platform = MethodChannel('com.example.nfcreaderapp/passport_reader');

  String _statusMessage = 'Scan result will appear here';
  String? _documentNumber;
  String? _dateOfBirth;
  String? _expirationDate;

  Future<void> _startMRZScan() async {
    setState(() {
      _statusMessage = "Starting MRZ scan...";
    });

    try {
      final dynamic result = await platform.invokeMethod('startMRZScan');

      if (result is Map) {
        _documentNumber = result['documentNumber']?.toString();
        _dateOfBirth = result['dateOfBirth']?.toString();
        _expirationDate = result['expirationDate']?.toString();

        setState(() {
          _statusMessage = '''
✅ MRZ Read Successfully:
Document Number: $_documentNumber
Date of Birth: $_dateOfBirth
Expiry Date: $_expirationDate

📲 Now hold the passport to the back of your phone for NFC...
''';
        });

        // Navigate to the NFC scan screen and start NFC read
        Get.to(() => NfcScanneView(
          documentNumber: _documentNumber!,
          dateOfBirth: _dateOfBirth!,
          expirationDate: _expirationDate!,
        ));
      } else if (result == "REQUESTING_PERMISSIONS") {
        setState(() {
          _statusMessage = "📋 Permissions requested. Please try again.";
        });
      } else {
        setState(() {
          _statusMessage = "⚠️ Unexpected MRZ scan result: $result";
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _statusMessage = "❌ PlatformException during MRZ scan: ${e.message}";
      });
    } catch (e, stackTrace) {
      setState(() {
        _statusMessage = "❌ Error during MRZ scan: $e";
      });
      print("❌ MRZ Exception: $e");
      print("📌 StackTrace: $stackTrace");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Step 1 - MRZ + NFC")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _startMRZScan,
              child: const Text('Start MRZ Scan'),
            ),
            const SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: SelectableText(_statusMessage))),
          ],
        ),
      ),
    );
  }
}
