import 'package:firstgetxapp/app/modules/forfait/controllers/forfait_controller.dart';
import 'package:get/get.dart';

class ForfaitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForfaitController>(() => ForfaitController());
  }
}
