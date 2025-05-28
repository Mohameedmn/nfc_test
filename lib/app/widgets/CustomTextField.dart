import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final RxString controllerRx;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controllerRx,
    this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
            obscureText: obscureText,
            onChanged: (value) => controllerRx.value = value,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              prefixIcon: icon != null ? Icon(icon) : null,
              border: const OutlineInputBorder(),
            ),
          ),
    );
  }
}

