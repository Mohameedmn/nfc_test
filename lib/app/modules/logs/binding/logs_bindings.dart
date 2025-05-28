import 'package:firstgetxapp/app/modules/logs/controller/logs_controller.dart';
import 'package:get/get.dart';

class LogsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogsController>(() => LogsController());
  }
}
