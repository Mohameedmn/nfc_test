import 'package:firstgetxapp/app/modules/stepper/controllers/request_Controller.dart';
import 'package:firstgetxapp/app/widgets/identitymatched.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stepper_controller.dart';
import '../../../widgets/custombutton.dart';

class SuccesView extends GetView<StepperController> {
  const SuccesView({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the RequestController
    final requestController = Get.put(RequestController());
    

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.check_circle,
                size: 60,
                color: Colors.green,
              ),
              const SizedBox(height: 10),
              const Text(
                'Vérification Faciale Réussie',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 17),
              const Text(
                'Votre identité a été confirmée avec succès.',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 40),
              const IdentityMatchCard(),
              const SizedBox(height: 30),
              const Text(
                "Vous pouvez maintenant passer à l'étape suivante.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: "Continuer",
                onPressed: () {
                  requestController.sendUserData();
                  print("hhhhh");
                },
                color: const Color(0xFFE60000),
                textColor: Colors.white,
                width: double.infinity,
                height: 50,
                borderRadius: 8.0,
                fontSize: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
