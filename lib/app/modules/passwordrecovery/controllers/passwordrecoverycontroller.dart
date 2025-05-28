import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/passwordrecoveryview2.dart';

class PasswordRecoveryController extends GetxController {
  // PHONE RECOVERY
  final phoneNumber = ''.obs;
  final phoneController = TextEditingController();

  // PASSWORD RESET
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;
  var showNewPassword = false.obs;
  var showConfirmPassword = false.obs;

  @override
  void onInit() {
    phoneController.addListener(() {
      phoneNumber.value = phoneController.text;
    });
    super.onInit();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  // Step 1: Phone Validation
  void validatePhoneNumber() {
    String phone = phoneNumber.value.trim();
    RegExp regex = RegExp(r'^07[0-9]{8}$');

    if (phone.isEmpty) {
      Get.snackbar("Error", "Phone number must not be empty",
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          colorText: Colors.white,
          duration: const Duration(seconds: 3));
    } else if (!regex.hasMatch(phone)) {
      Get.snackbar("Invalid number", "Enter a valid number starting with 07 and containing 10 digits",
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          colorText: Colors.white,
          duration: const Duration(seconds: 3));
    } else {
      Get.to(() => PasswordRecoveryView2());
    }
  }

  // Step 2: Password Validation
  bool get isPasswordValid =>
      newPassword.value.length >= 8 &&
      RegExp(r'[A-Z]').hasMatch(newPassword.value) && // at least one uppercase
      RegExp(r'[a-z]').hasMatch(newPassword.value) && // at least one lowercase
      RegExp(r'\d').hasMatch(newPassword.value) && // at least one digit
      RegExp(r'[!@#\$&*~%^()_\-+=<>?/\\|{}\[\]]')
          .hasMatch(newPassword.value); // at least one special character

  void resetPassword() {
    if (!isPasswordValid) {
      Get.snackbar("Error",
          "Invalid password. Minimum 8 characters, 1 uppercase, 1 lowercase, 1 digit, and 1 special character.",
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          colorText: Colors.white,
          duration: const Duration(seconds: 3));
      return;
    }

    if (newPassword.value != confirmPassword.value) {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          colorText: Colors.white,
          duration: const Duration(seconds: 3));
      return;
    }

    // TODO: Backend logic here
    Get.snackbar("Success", "Password reset successfully",
        backgroundColor: const Color.fromARGB(255, 250, 0, 0),
        colorText: Colors.white,
        duration: const Duration(seconds: 3));
    Get.offAllNamed("/login"); // go back to login
  }
}
