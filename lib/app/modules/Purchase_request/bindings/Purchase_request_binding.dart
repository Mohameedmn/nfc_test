import 'package:firstgetxapp/app/modules/Purchase_request/controller/Purchase_request_controller.dart';
import 'package:get/get.dart';

class PurchaseRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseRequestController>(() => PurchaseRequestController());
  }
}
