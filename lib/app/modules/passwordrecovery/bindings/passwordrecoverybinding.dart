import 'package:firstgetxapp/app/modules/passwordrecovery/controllers/passwordrecoverycontroller.dart';
import 'package:get/get.dart';

class PasswordRecoveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordRecoveryController>(() => PasswordRecoveryController());
  }
}
