import 'package:firstgetxapp/app/modules/Purchase_request/controller/Purchase_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PurchaseRequestView extends StatelessWidget {
  final controller = Get.find<PurchaseRequestController>();

  final statusLabels = {
    'pending': 'En cours',
    'accepted': 'Validée',
    'rejected': 'Rejetée',
  };

  final statusColors = {
    'pending': Colors.orange,
    'accepted': Colors.green,
    'rejected': Colors.red,
  };
  final statusIcons = {
    'pending': Icons.hourglass_empty,
    'accepted': Icons.check_circle,
    'rejected': Icons.cancel,
  };

  PurchaseRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final requests = controller.allRequests;

        if (requests.isEmpty) {
          return const Center(child: Text('Aucune demande trouvée.'));
        }

        return ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            final formattedDate = DateFormat('d MMM yyyy', 'fr_FR')
                .format(DateTime.parse(request.createdAt));
            final status = request.status;
            final color = statusColors[status];

            return Card(
              margin: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Numéro de demende : ${request.id}",
                            style: const TextStyle(color: Colors.grey)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: color?.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(children: [
                            Icon(statusIcons[status], color: color, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              statusLabels[status] ?? '',
                              style: TextStyle(
                                  color: color, fontWeight: FontWeight.bold),
                            ),
                          ]),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.sim_card_alert_outlined,
                            color: Colors.red),
                        const SizedBox(width: 8),
                        Text(request.profileType,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                        Icon(Icons.calendar_today, size: 16),
                        SizedBox(width: 8),
                        Text("Date de création : ",
                            style: TextStyle(color: Colors.grey)),
                        ],
                        ),
                        Text(formattedDate),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
