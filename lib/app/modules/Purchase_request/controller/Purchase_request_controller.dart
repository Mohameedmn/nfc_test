import 'package:firstgetxapp/app/core/utils/api/purchase_request_api.dart';
import 'package:firstgetxapp/app/models/subscriber_model.dart';
import 'package:get/get.dart';
import 'package:firstgetxapp/app/models/purchase_request_model.dart';

class PurchaseRequestController extends GetxController {
  RxList<PurchaseRequest> allRequests = <PurchaseRequest>[].obs;
  RxBool isLoading = false.obs;
  var purchase = Subscriber.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchPurchaseRequests();
  }

  Future<void> fetchPurchaseRequests() async {
  isLoading.value = true;
  try {
    final responseList = await PurchaseRequestApi.getMyRequests();
    final requests = responseList.map((json) {
      return PurchaseRequest.fromJson(json);
    }).toList();

    allRequests.value = requests;
  } catch (e) {

    allRequests.value = [];
  } finally {
    isLoading.value = false;
  }
}

}
