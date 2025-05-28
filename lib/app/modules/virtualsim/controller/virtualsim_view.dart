import 'package:firstgetxapp/app/widgets/MainEsim_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/virtualsim_controller.dart';

class VirtualSimView extends StatelessWidget {
  final VirtualSimController controller = Get.put(VirtualSimController());

  VirtualSimView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Status Dropdown
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.selectedStatus.value,
                      onChanged: (value) {
                        if (value != null) {
                          controller.setStatusFilter(value);
                        }
                      },
                      items: controller
                          .getAvailableStatuses()
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Profile Dropdown
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.selectedProfile.value,
                      onChanged: (value) {
                        if (value != null) {
                          controller.setProfileFilter(value);
                        }
                      },
                      items: controller
                          .getAvailableProfiles()
                          .map((profile) => DropdownMenuItem(
                                value: profile,
                                child: Text(profile),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: controller.filteredVirtualSims.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Image.asset('assets/images/not_found.png'),
                        const SizedBox(height: 15),
                        Text(
                          'Aucune eSIM disponible pour le moment.',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ))
                  : ListView.builder(
                      itemCount: controller.filteredVirtualSims.length,
                      itemBuilder: (context, index) {
                        final sim = controller.filteredVirtualSims[index];
                        final profileName =
                            controller.profileNames[sim.profileId] ??
                                "Loading...";

                        return MainEsimCard(
                          name: profileName,
                          status: sim.msisdn,
                          simCount: index + 1, // 👈 This makes it dynamic
                          imsi: sim.imsi,
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}
