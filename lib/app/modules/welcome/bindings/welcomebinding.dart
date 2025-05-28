import 'package:get/get.dart';
import '../controllers/welcomecontroller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    print("WelcomeController is being initialized");
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}

