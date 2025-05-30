import 'package:firstgetxapp/app/modules/faq/controller/faq_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqView extends StatelessWidget {
  final FaqController controller = Get.put(FaqController());

  final Map<String, IconData> categoryIcons = {
    'Carte SIM': Icons.sim_card,
    'eSIM': Icons.signal_cellular_alt,
    'NFC': Icons.nfc,
    'Inscription': Icons.assignment_ind,
  };
  final Map<String, Color> iconsColor = {
  'Carte SIM': Colors.blue,
  'eSIM': Colors.green,
  'NFC': Colors.purpleAccent,
  'Inscription': Colors.orange,
};



  FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aide & FAQ'),
        leading: const BackButton(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 10),
            Expanded(child: Obx(() => _buildFaqSections()))
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: controller.updateSearch,
      decoration: InputDecoration(
        hintText: 'Rechercher une question...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildFaqSections() {
    return ListView(
      children: controller.categories.map((category) {
        final faqs = controller.filteredFaqs(category);
        if (faqs.isEmpty) return const SizedBox(); // hide empty sections on search

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(categoryIcons[category], color: iconsColor[category], size: 24),
                  const SizedBox(width: 8),
                  Text(category,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ],
              ),
              const SizedBox(height: 6),
              ...faqs.map((faq) => _buildFaqTile(faq)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFaqTile(faq) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: ExpansionTile(
      title: Text(faq.question),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            faq.answer,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    ),
  );
}

}
