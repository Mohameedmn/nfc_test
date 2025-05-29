import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Step1View extends StatefulWidget {
  const Step1View({super.key});

  @override
  State<Step1View> createState() => _Step1ViewState();
}

class _Step1ViewState extends State<Step1View> {
  static const platform = MethodChannel('com.example.nfcreaderapp/passport_reader');

  String _statusMessage = 'Scan result will appear here';
  String? _documentNumber;
  String? _dateOfBirth;
  String? _expirationDate;
  bool _isReadingNfc = false;
  Uint8List? _faceImage;

  // Store full NFC data to display
  Map<String, dynamic>? _nfcData;

  Future<void> _startMRZScan() async {
    setState(() {
      _statusMessage = "Starting MRZ scan...";
      _faceImage = null;
      _nfcData = null;
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

        await _startNfcRead();
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

  Future<void> _startNfcRead() async {
  if (_documentNumber == null || _dateOfBirth == null || _expirationDate == null) {
    setState(() {
      _statusMessage = "⚠️ Missing MRZ data. Cannot start NFC read.";
    });
    return;
  }

  setState(() {
    _isReadingNfc = true;
    _statusMessage += "\n\n🔄 Reading NFC tag... Please keep the passport on the phone.";
  });

  try {
    final dynamic result = await platform.invokeMethod('readNfc', {
      'documentNumber': _documentNumber,
      'dateOfBirth': _dateOfBirth,
      'expirationDate': _expirationDate,
    });

    if (result is Map) {
      final Map<String, dynamic> nfcData = Map<String, dynamic>.from(result);

      // Fix the gender field if needed:
      var genderRaw = nfcData['gender'];
      if (genderRaw != null) {
        // It might be a complex object, so try to convert it to String
        if (genderRaw is String) {
          // Already a string, keep it
          nfcData['gender'] = genderRaw;
        } else {
          // If not string, try to parse as string by calling toString()
          nfcData['gender'] = genderRaw.toString().split('.').last; 
          // this extracts "FEMALE" from something like "Gender$2.FEMALE"
        }
      } else {
        nfcData['gender'] = "N/A";
      }

      setState(() {
        _statusMessage = '''
✅ NFC Data Read Successfully:

Name: ${nfcData['primaryIdentifier'] ?? 'N/A'} ${nfcData['secondaryIdentifier'] ?? ''}
Full Name: ${nfcData['fullName'] ?? 'N/A'}
Nationality: ${nfcData['nationality'] ?? 'N/A'}
Date of Birth: ${nfcData['dateOfBirth'] ?? 'N/A'}
Gender: ${nfcData['gender'] ?? 'N/A'}
Expiry Date: ${nfcData['dateOfExpiry'] ?? 'N/A'}
Document Number: ${nfcData['documentNumber'] ?? 'N/A'}
''';

        if (nfcData['faceImage'] != null && nfcData['faceImage'] is List<dynamic>) {
          final List<dynamic> bytesList = nfcData['faceImage'];
          _faceImage = Uint8List.fromList(bytesList.cast<int>());
        } else {
          _faceImage = null;
        }
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
    print("❌ PlatformException during NFC read: ${e.message}");
  } catch (e, stackTrace) {
    setState(() {
      _statusMessage = "❌ Error during NFC read: $e";
    });
    print("❌ NFC Exception: $e");
    print("📌 StackTrace: $stackTrace");
  } finally {
    setState(() {
      _isReadingNfc = false;
    });
  }
}


  Widget _buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value?.toString() ?? 'N/A'),
          ),
        ],
      ),
    );
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
              onPressed: _isReadingNfc ? null : _startMRZScan,
              child: const Text('Start MRZ Scan'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(_statusMessage),
                    if (_nfcData != null) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Passport Details:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      _buildInfoRow('Primary Identifier', _nfcData!['primaryIdentifier']),
                      _buildInfoRow('Secondary Identifier', _nfcData!['secondaryIdentifier']),
                      _buildInfoRow('Full Name', _nfcData!['fullName']),
                      _buildInfoRow('Nationality', _nfcData!['nationality']),
                      _buildInfoRow('Date of Birth', _nfcData!['dateOfBirth']),
                      _buildInfoRow('Gender', _nfcData!['gender']),
                      _buildInfoRow('Date of Expiry', _nfcData!['dateOfExpiry']),
                      _buildInfoRow('Document Number', _nfcData!['documentNumber']),
                      _buildInfoRow('Document Type', _nfcData!['documentType']),
                      _buildInfoRow('Issuing State', _nfcData!['issuingState']),
                      _buildInfoRow('Place of Birth', _nfcData!['placeOfBirth']),
                      _buildInfoRow('Other Names', _nfcData!['otherNames']),
                    ],
                    if (_faceImage != null) ...[
                      const SizedBox(height: 20),
                      Text("Face image from NFC data:", style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Center(
                        child: ClipOval(
                          child: Image.memory(
                            _faceImage!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
