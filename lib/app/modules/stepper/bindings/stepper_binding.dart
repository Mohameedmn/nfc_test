import 'package:firstgetxapp/app/modules/native/nativecontroller.dart';
import 'package:firstgetxapp/app/modules/profil/controller/profile_controller.dart';
import 'package:get/get.dart';
import '../controllers/stepper_controller.dart';

class StepperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StepperController>(() => StepperController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<StepperController>(() => StepperController());
    Get.lazyPut<NativePassportReaderService>(() => NativePassportReaderService());
  }
}
