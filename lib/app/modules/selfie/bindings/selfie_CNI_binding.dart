import 'package:firstgetxapp/app/modules/selfie/controllers/selfie_CNI_controller.dart';
import 'package:get/get.dart';

class SelfieCNIBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelfieCNIController>(() => SelfieCNIController());
  }
// Ensure the file ends properly and remove the misplaced `$SELECTION_PLACEHOLDER$`
}
