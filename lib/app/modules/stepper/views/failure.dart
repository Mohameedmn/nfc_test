import 'package:firstgetxapp/app/widgets/custombutton.dart';
import 'package:flutter/material.dart';

class FailureView extends StatelessWidget {
  const FailureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.error,
                size: 60,
                color: Colors.red,
              ),
              const SizedBox(height: 10),
              const Text(
                'Vérification Faciale Échouée',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Nous n'avons pas pu confirmer que votre visage correspond à la photo extraite de votre carte d'identité.",
                style: TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 25, bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pour une meilleure reconnaissance :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline,
                            color: Colors.red, size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Assurez-vous d'être bien éclairé(e)",
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF4A4A4A)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.sentiment_neutral,
                            color: Colors.red, size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Gardez une expression neutre",
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF4A4A4A)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.phone_android, color: Colors.red, size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Tenez le téléphone à hauteur du visage",
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF4A4A4A)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 190),
              CustomButton(
                text: "Quitter",
                onPressed: () {},
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
