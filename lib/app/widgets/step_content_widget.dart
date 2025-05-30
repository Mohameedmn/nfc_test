import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'custombutton.dart'; // adjust if needed

class StepContentWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;
  final bool isLottie; // NEW

  const StepContentWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    this.isLottie = false, // NEW
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLottie
              ? Lottie.asset(
                  imagePath,
                  height: 300,
                )
              : Image.asset(
                  imagePath,
                  height: 300,
                ),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          CustomButton(
            text: buttonText,
            onPressed: onPressed,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}