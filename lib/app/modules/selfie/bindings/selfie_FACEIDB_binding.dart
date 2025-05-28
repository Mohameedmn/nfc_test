import 'package:firstgetxapp/app/modules/selfie/controllers/selfie_controller.dart';
import 'package:get/get.dart';

class SelfieFACEIDBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelfieController>(() => SelfieController());
  }
// Ensure the file ends properly and remove the misplaced `$SELECTION_PLACEHOLDER$`
}