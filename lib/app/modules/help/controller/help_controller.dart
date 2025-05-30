import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpController extends GetxController {
  final supportNumber = '777'; // Replace with Djezzy's support number

  void callSupport() async {
    final uri = Uri(scheme: 'tel', path: '777');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          mode: LaunchMode.externalApplication); // important for Android 11+
    } else {
      Get.snackbar('Erreur', 'Impossible de lancer l’appel.');
    }
  }

  Future<void> openNearestBoutique() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Erreur', 'La localisation est désactivée.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Get.snackbar('Erreur', 'Permission de localisation refusée.');
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final latitude = position.latitude;
      final longitude = position.longitude;

      final uri = Uri.parse(
          'https://www.google.com/maps/search/Djezzy+Boutique/@$latitude,$longitude,15z');

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar('Erreur', 'Impossible d’ouvrir Google Maps.');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Une erreur est survenue : $e');
    }
  }
}
