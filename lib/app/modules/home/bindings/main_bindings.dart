import 'package:firstgetxapp/app/modules/Purchase_request/controller/Purchase_request_controller.dart';
import 'package:firstgetxapp/app/modules/combination/controllers/Combine_controller.dart';
import 'package:firstgetxapp/app/modules/faq/controller/faq_controller.dart';
import 'package:firstgetxapp/app/modules/forfait/controllers/forfait_controller.dart';
import 'package:firstgetxapp/app/modules/help/controller/help_controller.dart';
import 'package:firstgetxapp/app/modules/home/controllers/BottomNavController.dart';
import 'package:firstgetxapp/app/modules/infos/controllers/infos_controller.dart';
import 'package:firstgetxapp/app/modules/profil/controller/profile_controller.dart';
import 'package:firstgetxapp/app/modules/subscriber/controller/subscriber_controller.dart';
import 'package:firstgetxapp/app/modules/virtualsim/controller/virtualsim_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // This will lazily load the controller when needed
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    Get.lazyPut<SubscriberController>(() => SubscriberController());
    Get.lazyPut<ForfaitController>(() => ForfaitController());
    Get.lazyPut<VirtualSimController>(() => VirtualSimController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<InfosController>(() => InfosController());
    Get.lazyPut<PurchaseRequestController>(() => PurchaseRequestController());
    Get.lazyPut<FaqController>(() => FaqController());
    Get.lazyPut<HelpController>(() => HelpController());
    Get.lazyPut<CombineController>(() => CombineController());


  }
}
