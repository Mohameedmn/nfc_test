import 'package:firstgetxapp/app/modules/infos/controllers/infos_controller.dart';
import 'package:firstgetxapp/app/modules/subscriber/controller/subscriber_controller.dart';
import 'package:get/get.dart';

class InfosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfosController>(() => InfosController());
    Get.lazyPut<SubscriberController>(() => SubscriberController());

  }
}
