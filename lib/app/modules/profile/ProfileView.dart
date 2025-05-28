import 'package:firstgetxapp/app/modules/Purchase_request/view/Purchqse_request_view.dart';
import 'package:firstgetxapp/app/modules/faq/view/faq_view.dart';
import 'package:firstgetxapp/app/modules/forfait/views/forfait_view.dart';
import 'package:firstgetxapp/app/modules/help/view/help_view.dart';
import 'package:firstgetxapp/app/modules/infos/views/infos_view.dart';
import 'package:firstgetxapp/app/modules/stepper/views/step1_view.dart';
import 'package:firstgetxapp/app/widgets/ActivityTile.dart';
import 'package:firstgetxapp/app/widgets/QuickAccesTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(ForfaitView());
                },
                child: const ActivityTile(
                  icon: Icons.sim_card,
                  title: 'Mes offres',
                  subtitle: 'Voir les offres disponibles',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const Step1View());
                },
                child: const ActivityTile(
                  icon: Icons.qr_code,
                  title: 'Commander une eSIM',
                  subtitle: 'Démarrer la procédure',
                ),
              ),

              GestureDetector(
                onTap: () {
                  Get.to(InfosView());
                },
                child: const ActivityTile(
                  icon: Icons.perm_identity_rounded,
                  title: 'Mon compte',
                  subtitle: 'Modifier mes informations',
                ),
              ),

              const SizedBox(height: 24),
              const Text("Accès rapide", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.5,
                children: [
                  QuickAccessTile(
                    icon: Icons.notifications,
                    label: "Notifications",
                    onTap: () =>
                        Get.snackbar("Tapped", "Notifications clicked"),
                  ),
                  QuickAccessTile(
                    icon: Icons.headset_mic,
                    label: "Help & Support",
                    onTap: () => Get.to(const HelpView()),
                  ),
                  QuickAccessTile(
                    icon: Icons.settings,
                    label: "Paramètres",
                    onTap: () => Get.to(PurchaseRequestView()),
                  ),
                  QuickAccessTile(
                    icon: Icons.info,
                    label: "FAQ",
                    onTap: () => Get.to(FaqView()),
                  ),
                ],
              ),

              const SizedBox(height: 32), // spacing to avoid FAB overlap
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: const Icon(Icons.help_outline, color: Colors.white),
      ),
    );
  }
}
