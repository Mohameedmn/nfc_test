import 'package:firstgetxapp/app/modules/forfait/controllers/forfait_controller.dart';
import 'package:firstgetxapp/app/modules/profil/controller/profile_controller.dart';
import 'package:firstgetxapp/app/modules/stepper/views/step1_view.dart';
import 'package:firstgetxapp/app/modules/subscriber/controller/subscriber_controller.dart';
import 'package:firstgetxapp/app/modules/virtualsim/controller/virtualsim_controller.dart';
import 'package:firstgetxapp/app/modules/virtualsim/controller/virtualsim_view.dart';
import 'package:firstgetxapp/app/widgets/ActivityTile.dart';
import 'package:firstgetxapp/app/widgets/Esim_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final subscriberController = Get.find<SubscriberController>();
  final offerController = Get.find<ForfaitController>();
  final virtualSimController = Get.find<VirtualSimController>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active eSIM Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          final subscriber =
                              subscriberController.subscriber.value;
                          if (subscriber == null) {
                            return const Text(
                              'Chargement...',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            );
                          }
                          return Text(
                            'Vous avez ${subscriber.activeEsim} eSIM ${subscriber.activeEsim > 1 ? 'actives' : 'active'}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          );
                        }),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Get.to(VirtualSimView()); // Navigate to VirtualSimView
                          },
                          child: const Text('Afficher'),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    final subscriber = subscriberController.subscriber.value;
                    return CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Text(
                        subscriber != null ? '${subscriber.activeEsim}' : '...',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Obx(() {
              if (virtualSimController.isLoading.value ||
                  profileController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: virtualSimController.virtualSims
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key + 1; // simCount starting from 1
                    final virtualSim = entry.value;

                    final profile =
                        profileController.profilesMap[virtualSim.profileId];
                    final name = profile?.commercialName ?? 'Unknown';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: EsimCard(
                        simCount: index,
                        name: name,
                        status: virtualSim.msisdn,
                      ),
                    );
                  }).toList(),
                ),
              );
            }),

            const SizedBox(height: 20),

            // Activity Header
            const Text(
              'Activité récente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Activity List
            const ActivityTile(
              icon: Icons.swap_horiz,
              title: 'Changement de forfait vers IZZY',
              subtitle: 'Hier',
            ),
            const ActivityTile(
              icon: Icons.videocam,
              title: 'Identification vidéo validée',
              subtitle: '12 Avril 2025',
            ),
            const ActivityTile(
              icon: Icons.shopping_cart,
              title: 'Commande eSIM effectuée',
              subtitle: '10 Avril 2025',
            ),

                        const SizedBox(height: 20),

            // New eSIM Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Navigate to the new eSIM order page
                  Get.to(const Step1View()); // Pushes a new page onto the stack

                },
                child: const Text(
                  'Commander une nouvelle eSIM',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
