// lib/app/modules/step1_mrz/step1_mrz_view.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Step1MRZView extends StatefulWidget {
  const Step1MRZView({super.key});

  @override
  State<Step1MRZView> createState() => _Step1MRZViewState();
}

class _Step1MRZViewState extends State<Step1MRZView> {
  static const platform = MethodChannel('com.example.nfcreaderapp/passport_reader');

  String _statusMessage = 'Scan result will appear here';
  bool _isScanning = false;

  String? _documentNumber;
  String? _dateOfBirth;
  String? _expirationDate;

  Future<void> _startMRZScan() async {
    setState(() {
      _isScanning = true;
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
''';
        });

        // Navigate to Step 2 and pass MRZ data
        Get.toNamed('/step2nfc', arguments: {
          'documentNumber': _documentNumber,
          'dateOfBirth': _dateOfBirth,
          'expirationDate': _expirationDate,
        });
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
    } catch (e) {
      setState(() {
        _statusMessage = "❌ Error during MRZ scan: $e";
      });
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Step 1 - MRZ Scan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isScanning ? null : _startMRZScan,
              child: const Text("Start MRZ Scan"),
            ),
            const SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: SelectableText(_statusMessage))),
          ],
        ),
      ),
    );
  }
}
