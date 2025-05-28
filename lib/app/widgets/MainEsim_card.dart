import 'package:firstgetxapp/app/modules/forfait/views/forfait_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainEsimCard extends StatelessWidget {
  final String name;
  final String status;
  final int simCount;
  final String imsi;

  const MainEsimCard({
    super.key,
    required this.name,
    required this.status,
    required this.simCount,
    required this.imsi,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(status);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.sim_card,
                  color: Colors.red,
                ),
                const SizedBox(height: 20),
                Text(
                  'eSIM $simCount',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Identifiant SIM :    $imsi'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      border: Border.all(color: color),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.circle,
                        color: color,
                        size: 10,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        status,
                        style: TextStyle(color: color),
                      ),
                    ])),
              ],
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Navigate to the new eSIM order page
                  Get.to(ForfaitView()); // Pushes a new page onto the stack
                },
                child: const Text(
                  'Voir mes offres',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

Color _getStatusColor(String msisdn) {
  switch (msisdn) {
    case 'active':
      return Colors.green;
    case 'blocked':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
