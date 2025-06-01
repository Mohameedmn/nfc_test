import 'dart:typed_data';
import 'package:firstgetxapp/app/modules/stepper/controllers/nfcscanne_controller.dart';
import 'package:firstgetxapp/app/modules/stepper/views/succes.dart';
import 'package:firstgetxapp/app/widgets/custombutton.dart';
import 'package:flutter/material.dart';
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
  final StepperController _stepperController = StepperController();

  final NfcScanneController _controller = NfcScanneController();

  @override
  void initState() {
    super.initState();
    _controller.startNfcRead(
      widget.documentNumber,
      widget.dateOfBirth,
      widget.expirationDate,
      onSuccess: (nfcData, faceImage) {
        _stepperController.setNfcData(nfcData, faceImage);
        setState(() {});
      },
      onUpdate: () => setState(() {}),
    );
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
          onPressed: () => Get.back(),
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
              if (_controller.isReading) ...[
                const CircularProgressIndicator(
                  color: Color(0xFFE60000),
                  strokeWidth: 2,
                ),
                const SizedBox(height: 30),
                Text(_controller.statusMessage, textAlign: TextAlign.center),
              ] else if (_controller.nfcData != null) ...[
                if (_controller.faceImage != null) ...[
                  const SizedBox(height: 240),
                  CustomButton(
                    text: 'Continuer',
                    onPressed: () {
                      print("NFC Data: ${_controller.nfcData}");
                      
                      Get.to(const SuccesView());

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
