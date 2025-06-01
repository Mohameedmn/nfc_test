import 'package:firstgetxapp/app/modules/profil/controller/profile_controller.dart';
import 'package:firstgetxapp/app/modules/selfie/controllers/selfie_faceID.dart';
import 'package:firstgetxapp/app/modules/subscriber/controller/subscriber_controller.dart';
import 'package:get/get.dart';
import '../controllers/stepper_controller.dart';
import '../controllers/nfcscanne_controller.dart';
import '../controllers/request_Controller.dart';

class StepperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StepperController>(() => StepperController());
    Get.lazyPut<ProfileController>(() => ProfileController());
     Get.lazyPut<RequestController>(() => RequestController());
     Get.lazyPut<NfcScanneController>(() => NfcScanneController());
     Get.lazyPut<SubscriberController>(() => SubscriberController());
    Get.lazyPut<SelfieFaceIDController>(() => SelfieFaceIDController());

  }
}
