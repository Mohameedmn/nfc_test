import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NfcScanneController extends GetxController {
  static const platform = MethodChannel('com.example.nfcreaderapp/passport_reader');

  String statusMessage = "Placez votre carte d'identité biométrique au dos de votre téléphone pour lire les données NFC.";
  Uint8List? faceImage;
  Map<String, dynamic>? nfcData;
  bool isReading = false;

  Future<void> startNfcRead(
    String documentNumber,
    String dateOfBirth,
    String expirationDate, {
    required Function(Map<String, dynamic>, Uint8List) onSuccess,
    required VoidCallback onUpdate,
  }) async {
    isReading = true;
    statusMessage = "Lecture NFC en cours... veuillez garder la carte sur votre téléphone.";
    onUpdate();

    bool success = false;

    while (!success) {
      try {
        final dynamic result = await platform.invokeMethod('readNfc', {
          'documentNumber': documentNumber,
          'dateOfBirth': dateOfBirth,
          'expirationDate': expirationDate,
        });

        if (result is Map) {
          print("NFC Data: $result");
          final Map<String, dynamic> rawNfcData = Map<String, dynamic>.from(result);

          var genderRaw = rawNfcData['gender'];
          rawNfcData['gender'] = genderRaw != null
              ? (genderRaw is String ? genderRaw : genderRaw.toString().split('.').last)
              : "N/A";

            

          Uint8List? image;
          if (rawNfcData['faceImage'] != null && rawNfcData['faceImage'] is List<dynamic>) {
            image = Uint8List.fromList((rawNfcData['faceImage'] as List).cast<int>());
          }

          if (image != null) {
            nfcData = rawNfcData;
            faceImage = image;
            statusMessage = "✅ Lecture NFC réussie !";
            isReading = false;
            onUpdate();
            onSuccess(nfcData!, faceImage!);
            success = true;
            break;
          } else {
            statusMessage = "🔄 Lecture réussie mais image manquante. Nouvelle tentative...";
          }
        } else {
          statusMessage = "⚠️ Résultat inattendu : $result. Nouvelle tentative...";
        }
      } on PlatformException catch (e) {
        statusMessage = "❌ Erreur plateforme : ${e.message}. Nouvelle tentative...";
      } catch (e) {
        statusMessage = "❌ Erreur inconnue : $e. Nouvelle tentative...";
      }

      onUpdate();
      await Future.delayed(const Duration(seconds: 2));
    }

    if (!success) {
      isReading = false;
      statusMessage = "Échec après plusieurs tentatives.";
      onUpdate();
    }
  }
}
