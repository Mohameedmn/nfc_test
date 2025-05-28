import 'package:firstgetxapp/app/core/utils/api/auth_api.dart';
import 'package:firstgetxapp/app/modules/logs/controller/logs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString phonenumber = ''.obs;
  RxString password = ''.obs;
  late LogsController logsController;
  final RegExp phoneRegex = RegExp(r'^07\d{8}$'); // 07 + 8 digits = 10 total


  @override
  void onInit() {
    super.onInit();
    logsController = Get.find<LogsController>();
  }
  
  void login() async {
    final phone = phonenumber.value.trim();
    final pass = password.value.trim();

    // Validation
    if (phone.isEmpty || pass.isEmpty) {
      Get.snackbar("Error", "Phone and password must not be empty");
      return;
    }

    if (!phoneRegex.hasMatch(phone)) {
      Get.snackbar(
          "Invalid Phone", "Phone number must be 10 digits and start with 07");
      return;
    }

    if (pass.length < 8) {
      Get.snackbar(
          "Invalid Password", "Password must be at least 8 characters");
      return;
    }

    // API call
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      final success = await AuthApi.login(phone, pass);
      Get.back(); // remove loading
      if (success) {
        Get.snackbar("Success", "Login successful");
        print('Creating login log...');
        logsController.createLog(
          action: 'login',
          actionType: 'Authentication',
        ); // Log the login action
        Get.offAllNamed('/main'); // navigate to home after login
      } else {
        Get.snackbar("Login Failed", "Check your credentials and try again");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
