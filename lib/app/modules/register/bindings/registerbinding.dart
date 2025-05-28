import 'package:get/get.dart';
import '../controllers/registercontroller.dart';  // Import the RegisterController

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load the RegisterController
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
