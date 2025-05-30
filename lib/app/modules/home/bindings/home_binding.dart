import 'package:firstgetxapp/app/modules/forfait/controllers/forfait_controller.dart';
import 'package:firstgetxapp/app/modules/subscriber/controller/subscriber_controller.dart';
import 'package:firstgetxapp/app/modules/virtualsim/controller/virtualsim_controller.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // This will lazily load the controller when needed
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ForfaitController>(() => ForfaitController());
    Get.lazyPut<SubscriberController>(() => SubscriberController());
    Get.lazyPut<VirtualSimController>(() => VirtualSimController());
    //Get.lazyPut<ProfileController>(() => ProfileController());



  }
}
