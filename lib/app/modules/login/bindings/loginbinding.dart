import 'package:firstgetxapp/app/modules/logs/controller/logs_controller.dart';
import 'package:get/get.dart';
import '../controllers/logincontroller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<LogsController>(() => LogsController());
    

  }
}
