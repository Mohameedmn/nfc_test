import 'package:firstgetxapp/app/widgets/CustomOfferCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firstgetxapp/app/modules/forfait/controllers/forfait_controller.dart';

class ForfaitView extends GetView<ForfaitController> {
  ForfaitView({super.key});

  final forfaitController = Get.find<ForfaitController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (forfaitController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: forfaitController.offers.length,
            itemBuilder: (context, index) {
              final offer = forfaitController.offers[index];
              return CustomOfferCard(
                name: offer.name,
                description: offer.description,
                price: offer.price.toInt().toString(),
                oldData: 6,
                newData: 3,
                duration: '1 mois',
              );
            },
          );
        }),
      ),
    );
  }
}
