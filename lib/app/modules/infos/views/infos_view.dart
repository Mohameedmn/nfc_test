import 'package:firstgetxapp/app/modules/infos/controllers/infos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class InfosView extends StatelessWidget {
  InfosView({super.key});

  final infoscontroller = Get.find<InfosController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mon Profil")),
      body: Obx(() {
        final identityDocument = infoscontroller.identityDocument.value;
        final isLoading = infoscontroller.isLoading.value;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (identityDocument == null) {
          return const Center(child: Text("Aucun document d'identité trouvé."));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _infoCard("Nom", identityDocument.lastName, LucideIcons.user),
            _infoCard("Prénom", identityDocument.firstName, LucideIcons.user),
            _infoCard("Date de naissance", identityDocument.birthDate,LucideIcons.calendar),
            _infoCard("Sexe",identityDocument.gender,
              identityDocument.gender.toLowerCase() == "male"? Icons.male: Icons.female,
            ),
            _infoCard("Numéro CNI", identityDocument.documentNumber.toString(),
                Icons.badge),
            _infoCard(
                "Nationalité", identityDocument.nationality, LucideIcons.flag),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: infoscontroller.logout,
              icon: const Icon(Icons.logout),
              label: const Text("Déconnexion",
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      }),
    );
  }

  Widget _infoCard(String label, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(label),
        subtitle:
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
