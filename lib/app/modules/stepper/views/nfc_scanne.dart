import 'package:firstgetxapp/app/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NfcScanneView extends StatelessWidget {
  const NfcScanneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Scanner votre carte d’identité",),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),

                const Text(
                  "Placez votre carte d'identité biométrique au dos de votre téléphone pour lire les données NFC.",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                Image.asset(
                  'assets/images/nfc.png',
                  height: 250,
                  width: double.infinity,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Assurez-vous que votre carte est bien positionnée et que le NFC est activé sur votre téléphone.",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                //loading animation
                const CircularProgressIndicator(
                  color: Color(0xFFE60000),
                  strokeWidth: 2,
                ),

                // yrad l button lta7ta ga3

                const Spacer(),



                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                          text: "Annuler",
                          onPressed: () {
                            // Get.toNamed(''); // Replace with your next step route
                          },
                          //F3F4F6
                          color: const Color(0xFFF3F4F6),
                          textColor: const Color.fromARGB(255, 7, 7, 7),
                          width: double.infinity,
                          height: 50,
                          borderRadius: 8.0,
                          fontSize: 15.0,
                        )),
                    const SizedBox(width: 20),
                    Expanded(
                        child: CustomButton(
                          text: "Continuer",
                          onPressed: () {

                          },

                          color: const Color(0xFFE60000),
                          textColor: Colors.white,
                          width: double.infinity,
                          height: 50,
                          borderRadius: 8.0,
                          fontSize: 15.0,
                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
