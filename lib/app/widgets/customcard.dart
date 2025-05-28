import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String mainText;
  final String subText;
  final double height;
  final double width;
  final EdgeInsetsGeometry margin;

  // Constructor to accept parameters
  const CustomCard({
    super.key,
    required this.mainText,
    required this.subText,
    this.height = 100.0,
    this.width = 110.0,
    this.margin = const EdgeInsets.only(top: 20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mainText,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4), // space between texts
            Text(
              subText,
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
