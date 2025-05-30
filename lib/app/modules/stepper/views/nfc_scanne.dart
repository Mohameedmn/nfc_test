import 'dart:typed_data';
import 'package:firstgetxapp/app/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/stepper_controller.dart';

class NfcScanneView extends StatefulWidget {
  final String documentNumber;
  final String dateOfBirth;
  final String expirationDate;

  const NfcScanneView({
    Key? key,
    required this.documentNumber,
    required this.dateOfBirth,
    required this.expirationDate,
  }) : super(key: key);

  @override
  State<NfcScanneView> createState() => _NfcScanneViewState();
}

class _NfcScanneViewState extends State<NfcScanneView> {
  static const platform = MethodChannel('com.example.nfcreaderapp/passport_reader');

  final StepperController _stepperController = Get.find<StepperController>();

  String _statusMessage = "Placez votre carte d'identité biométrique au dos de votre téléphone pour lire les données NFC.";
  Uint8List? _faceImage;
  Map<String, dynamic>? _nfcData;
  bool _isReading = false;

  @override
  void initState() {
    super.initState();
    _startNfcRead();
  }

  Future<void> _startNfcRead() async {
    setState(() {
      _isReading = true;
      _statusMessage = "Lecture NFC en cours... veuillez garder la carte sur votre téléphone.";
    });

    bool success = false;

    while (!success && mounted) {
      try {
        final dynamic result = await platform.invokeMethod('readNfc', {
          'documentNumber': widget.documentNumber,
          'dateOfBirth': widget.dateOfBirth,
          'expirationDate': widget.expirationDate,
        });

        if (result is Map) {
          final Map<String, dynamic> nfcData = Map<String, dynamic>.from(result);

          // Fix gender field
          var genderRaw = nfcData['gender'];
          if (genderRaw != null) {
            if (genderRaw is String) {
              nfcData['gender'] = genderRaw;
            } else {
              nfcData['gender'] = genderRaw.toString().split('.').last;
            }
          } else {
            nfcData['gender'] = "N/A";
          }

          Uint8List? faceImage;
          if (nfcData['faceImage'] != null && nfcData['faceImage'] is List<dynamic>) {
            final List<dynamic> bytesList = nfcData['faceImage'];
            faceImage = Uint8List.fromList(bytesList.cast<int>());
          }

          if (faceImage != null) {
            // Store data and image in controller
            _stepperController.setNfcData(nfcData, faceImage);

            setState(() {
              _nfcData = nfcData;
              _faceImage = faceImage;
              _statusMessage = "✅ Lecture NFC réussie !";
              _isReading = false;
            });
            success = true;
            break;
          } else {
            setState(() {
              _statusMessage = "🔄 Lecture réussie mais image manquante. Nouvelle tentative...";
            });
          }
        } else {
          setState(() {
            _statusMessage = "⚠️ Résultat inattendu : $result. Nouvelle tentative...";
          });
        }
      } on PlatformException catch (e) {
        setState(() {
          _statusMessage = "❌ Erreur plateforme : ${e.message}. Nouvelle tentative...";
        });
        print("PlatformException: ${e.message}");
      } catch (e, stackTrace) {
        setState(() {
          _statusMessage = "❌ Erreur inconnue : $e. Nouvelle tentative...";
        });
        print("Exception: $e\nStackTrace: $stackTrace");
      }

      await Future.delayed(const Duration(seconds: 2));
    }

    if (!success && mounted) {
      setState(() {
        _isReading = false;
        _statusMessage = "Échec après plusieurs tentatives.";
      });
    }
  }


  Widget _buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value?.toString() ?? 'N/A')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanner votre carte d’identité"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Placez votre carte d'identité biométrique au dos de votre téléphone pour lire les données NFC.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),

              Image.asset(
                'assets/images/nfc_scanner.png',
                width: 200,
                height: 200,
              ),

              if (_isReading) ...[
                const CircularProgressIndicator(
                  color: Color(0xFFE60000),
                  strokeWidth: 2,
                ),
                const SizedBox(height: 30),
                Text(_statusMessage, textAlign: TextAlign.center),
              ] else if (_nfcData != null) ...[
                if (_faceImage != null) ...[
                  const SizedBox(height: 240),

                  CustomButton(
                    text: 'Continuer',
                    
                    onPressed: () {
                      print("NFC Data: $_nfcData");
                      Get.toNamed('/step2'); // Or whatever your next route is
                    },
                    color: const Color(0xFFE60000),
                    textColor: Colors.white,
                    width: double.infinity,
                    height: 50,
                    borderRadius: 8.0,
                    fontSize: 16.0,
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
