import 'package:camera/camera.dart';
import 'package:firstgetxapp/app/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/selfie_faceID.dart';

class SelfieView1 extends GetView<SelfieFaceIDController> {
  const SelfieView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //back app bar
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
          },
        ),
      ),

      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: SingleChildScrollView(
            //no scroll
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  const Text(
                    "Vérification d'Identité – Capture Vidéo",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Nous allons enregistrer une courte vidéo pour confirmer votre identité. Cela ne prendra que quelques secondes.",
                    style: TextStyle(
                      fontSize: 12,
                      //#059669 color
                      color: Colors.grey[600], // Fallback color
                    ),
                    //textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 7), 

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: AspectRatio(
                      aspectRatio:
                          controller.cameraController.value.aspectRatio,
                      child: CameraPreview(controller.cameraController),
                    ),
                  ),
                  const SizedBox(height: 20),

                
              

                  CustomButton(
                    
                    text: controller.isRecording.value
                        ? "Veuiller patienter..."
                        : "Démarrer l'Enregistrement",
                    onPressed: controller.isRecording.value
                        ? controller.stopRecording
                        : controller.startRecording,
                    color: controller.isRecording.value
                    
                        ? Colors.grey
                        :Colors.red,
                         
                    textColor: Colors.white,
                    width: double.infinity,
                    height: 50,
                    borderRadius: 8.0,
                    fontSize: 16.0,
                  ),

                  const SizedBox(height: 10),
                  CustomButton(
                    text: "Continuer",
                    width: double.infinity,
                    height: 50,
                    color: const Color(0xFF059669),
                    textColor: Colors.white,
                    borderRadius: 8.0,
                    fontSize: 16.0,
                    onPressed: () {
                      if(!controller.isRecording.value && controller.recordedVideo.value != null
                      ) {
                        
                        Get.snackbar(
                          "Succès",
                          "Vidéo enregistrée avec succès !",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                       Get.offNamed('/step3');
                      }                 
                   },
                  ),

                  

                  
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}