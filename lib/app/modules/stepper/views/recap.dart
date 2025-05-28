import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stepper_controller.dart';
import '../../../widgets/recap_card.dart';

class RecapView extends GetView<StepperController> {
  const RecapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        decoration: const BoxDecoration(
      ),
        
        child: const Column(
          children: [
            RecapCard(
          title: "Identité",
          icon: Icons.person,
          data: {
            "Nom": "JIKA",
            "Prénom": "Mohammed",
            "Numéro CNI": "198276349",
            "Date de naissance": "15/03/1990",
            "Nationalité": "Algérienne",
            "Sexe": "Homme",
          },
        ),
        RecapCard(title: "Offre Choisie",
          icon: Icons.person,
          data: {
            "Type": "JIKA",
            "Prénom": "Mohammed",
            "Numéro CNI": "198276349",
          },)
       
          ],
        )
      ),
    );
  }
}
