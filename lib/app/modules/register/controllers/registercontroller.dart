import 'package:firstgetxapp/app/core/utils/api/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxString firstname = ''.obs;
  RxString lastname = ''.obs;
  RxString phonenumber = ''.obs;
  RxString password = ''.obs;
  RxString confirmPassword = ''.obs;

  // Regex patterns
  final RegExp nameRegex = RegExp(r"^[a-zA-Z]+$");
  final RegExp passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');

  void register() async {
  if (!_validateFields()) return;

  try {
  final success = await AuthApi.register(
    phone_number: phonenumber.value,
    password: password.value,
    confirmPassword: confirmPassword.value,
  );

  if (success) {
    Get.snackbar("Success", "Account created successfully!");
    Get.offAllNamed('/main'); 
  } else {
    Get.snackbar("Registration Failed", "Please check your data and try again.");
  }
} catch (e) {
  Get.snackbar("Error", "Registration failed: $e");
}
}

  bool _validateFields() {
  if (!RegExp(r'^07\d{8}$').hasMatch(phonenumber.value)) {
    Get.snackbar(
      "Error",
      "Phone number must contain 10 digits and start with 07",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.TOP,
    );
    return false;
  }

  if (!passwordRegex.hasMatch(password.value)) {
    Get.snackbar(
      "Error",
      "Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one digit, and one special character",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.TOP,
    );
    return false;
  }

  if (password.value != confirmPassword.value) {
    Get.snackbar(
      "Error",
      "Passwords do not match",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.TOP,
    );
    return false;
  }

  return true;
}

}
