import 'dart:typed_data';
import 'package:firstgetxapp/app/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

    try {
      final dynamic result = await platform.invokeMethod('readNfc', {
        'documentNumber': widget.documentNumber,
        'dateOfBirth': widget.dateOfBirth,
        'expirationDate': widget.expirationDate,
      });

      if (result is Map) {
        final Map<String, dynamic> nfcData = Map<String, dynamic>.from(result);

        // Fix gender field if necessary
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

        setState(() {
          _nfcData = nfcData;
          _statusMessage = "✅ Lecture NFC réussie ! Voici les détails :";

          if (nfcData['faceImage'] != null && nfcData['faceImage'] is List<dynamic>) {
            final List<dynamic> bytesList = nfcData['faceImage'];
            _faceImage = Uint8List.fromList(bytesList.cast<int>());
          } else {
            _faceImage = null;
          }
        });
      } else {
        setState(() {
          _statusMessage = "⚠️ Résultat inattendu lors de la lecture NFC : $result";
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _statusMessage = "❌ Erreur plateforme lors de la lecture NFC : ${e.message}";
      });
      print("PlatformException during NFC read: ${e.message}");
    } catch (e, stackTrace) {
      setState(() {
        _statusMessage = "❌ Erreur lors de la lecture NFC : $e";
      });
      print("NFC Exception: $e");
      print("StackTrace: $stackTrace");
    } finally {
      setState(() {
        _isReading = false;
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


              //image
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
                Text(_statusMessage, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const SizedBox(height: 20),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('Nom', _nfcData!['primaryIdentifier']),
                        _buildInfoRow('Prénom', _nfcData!['secondaryIdentifier']),
                        _buildInfoRow('Nom complet', _nfcData!['fullName']),
                        _buildInfoRow('Nationalité', _nfcData!['nationality']),
                        _buildInfoRow('Date de naissance', _nfcData!['dateOfBirth']),
                        _buildInfoRow('Genre', _nfcData!['gender']),
                        _buildInfoRow('Date d’expiration', _nfcData!['dateOfExpiry']),
                        _buildInfoRow('Numéro de document', _nfcData!['documentNumber']),
                      ],
                    ),
                  ),
                ),

                if (_faceImage != null) ...[
                  const SizedBox(height: 20),
                  Text("Photo du visage :", style: Theme.of(context).textTheme.titleMedium),
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

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        child: const Text('Retour'),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // You can implement "Next step" here
                          Get.snackbar('Info', 'Next step not implemented yet.');
                        },
                        child: const Text('Suivant'),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Text(_statusMessage, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Continuer',
                  onPressed: () {

                  },
                  
                  color: const Color(0xFFE60000),
                  textColor: Colors.white,
                  width: double.infinity,
                  height: 50,
                  borderRadius: 8.0,
                  fontSize: 16.0,
                ),
                
              ]
            ],
          ),
        ),
      ),
    );
  }
}
