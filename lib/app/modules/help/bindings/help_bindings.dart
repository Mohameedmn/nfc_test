import 'package:firstgetxapp/app/modules/help/controller/help_controller.dart';
import 'package:get/get.dart';

class HelpBindings extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<HelpController>(() => HelpController());

  }
}
