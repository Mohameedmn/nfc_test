import 'package:firstgetxapp/app/modules/profil/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stepper_controller.dart';
import 'package:firstgetxapp/app/models/profile_model.dart';

class Step3View extends GetView<StepperController> {
  Step3View({super.key});

  final profileController = Get.find<ProfileController>(); 

  final List<IconData> icons = [
    Icons.phone_android,
    Icons.star,
    Icons.wifi,
    Icons.security,
  ];

  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisissez votre type'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: 0.8, // step 4/5
            backgroundColor: Colors.grey[300],
            color: Colors.red,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Sélectionnez un type qui correspond le mieux à vos besoins",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (profileController.profiles.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: profileController.profiles.length,
                itemBuilder: (context, index) {
                  final Profile profile = profileController.profiles[index];
                  return _buildCard(
                    index: index,
                    title: profile.commercialName,
                    description: profile.description,
                    icon: icons[index % icons.length],
                    color: colors[index % colors.length],
                  );
                },
              );
            }),
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.selectedCardIndex.value != -1
                      ? () {
                          Get.toNamed('/selfie-compare');
                        }
                      : null,
                  child: const Text('Confirmer mon choix'),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCard({
    required int index,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Obx(() => GestureDetector(
          onTap: () {
            controller.selectedCardIndex.value = index;
            print("Selected card index: ${controller.selectedCardIndex.value}");
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: controller.selectedCardIndex.value == index
                    ? Colors.red
                    : Colors.transparent,
                width: 2,
              ),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(
                icon,
                color: color,
                size: 32,
              ),
              title: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(description),
                ],
              ),
              trailing: Radio<int>(
                value: index,
                groupValue: controller.selectedCardIndex.value,
                onChanged: (value) {
                  controller.selectedCardIndex.value = value!;
                },
              ),
            ),
          ),
        ));
  }
}
