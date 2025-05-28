import 'package:flutter/material.dart';
import 'custombutton.dart'; // adjust the import if needed

class StepContentWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const StepContentWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
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
