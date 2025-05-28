import 'package:firstgetxapp/app/modules/selfie/controllers/compare_controller.dart';
import 'package:get/get.dart';

class FaceCompareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceCompareController>(() => FaceCompareController());
  }
}
