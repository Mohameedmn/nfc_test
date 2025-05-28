import 'package:firstgetxapp/app/core/utils/api/auth_api.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var counter = 0.obs;

  void increment() {
    counter++;
  }

  Future<void> logout() async {
    try {
      await AuthApi.logout(); // Call the void function
      Get.offAllNamed('/login'); // Navigate to login page
      Get.snackbar("Logged Out", "You have been logged out successfully.");
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}