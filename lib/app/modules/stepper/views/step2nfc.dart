// lib/app/modules/step2_nfc/step2_nfc_view.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Step2NFCView extends StatefulWidget {
  const Step2NFCView({super.key});

  @override
  State<Step2NFCView> createState() => _Step2NFCViewState();
}

class _Step2NFCViewState extends State<Step2NFCView> {
  static const platform = MethodChannel('com.example.nfcreaderapp/passport_reader');

  String _statusMessage = 'NFC scan result will appear here';
  bool _isReading = false;

  String? _documentNumber;
  String? _dateOfBirth;
  String? _expirationDate;

  @override
  void initState() {
    super.initState();
    _extractArgumentsAndStartNFC();
  }

  void _extractArgumentsAndStartNFC() {
    final args = Get.arguments;
    _documentNumber = args['documentNumber'];
    _dateOfBirth = args['dateOfBirth'];
    _expirationDate = args['expirationDate'];

    if (_documentNumber != null && _dateOfBirth != null && _expirationDate != null) {
      _startNFCReading();
    } else {
      setState(() {
        _statusMessage = "❌ MRZ data not found. Please scan again.";
      });
    }
  }

  Future<void> _startNFCReading() async {
    setState(() {
      _isReading = true;
      _statusMessage = "Starting NFC read...";
    });

    try {
      final dynamic result = await platform.invokeMethod('readPassport', {
        'documentNumber': _documentNumber,
        'dateOfBirth': _dateOfBirth,
        'expirationDate': _expirationDate,
      });

      if (result is String) {
        setState(() {
          _statusMessage = "✅ NFC Read Success:\n$result";
        });
      } else {
        setState(() {
          _statusMessage = "⚠️ Unexpected NFC read result: $result";
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _statusMessage = "❌ PlatformException during NFC read: ${e.message}";
      });
    } catch (e) {
      setState(() {
        _statusMessage = "❌ Error during NFC read: $e";
      });
    } finally {
      setState(() {
        _isReading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Step 2 - NFC Reading")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_isReading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _startNFCReading,
                child: const Text("🔁 Retry NFC Read"),
              ),
            const SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: SelectableText(_statusMessage))),
          ],
        ),
      ),
    );
  }
}
