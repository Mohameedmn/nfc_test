import 'package:firstgetxapp/app/core/utils/api/auth_api.dart';
// ignore: library_prefixes
import 'package:firstgetxapp/app/core/utils/api/subscriber_api.dart' as SubscriberApi;
import 'package:firstgetxapp/app/models/identitydocument_model.dart';
import 'package:firstgetxapp/app/models/subscriber_model.dart';
import 'package:get/get.dart';

class InfosController extends GetxController {
  var subscriber = Subscriber.empty().obs;
  Rxn<IdentityDocument> identityDocument = Rxn<IdentityDocument>();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchSubscriber();
    fetchIdentityDocument();
  }

  void fetchSubscriber() async {
    final data = await SubscriberApi.getCurrentSubscriber();

    if (data != null) {
      subscriber.value = Subscriber.fromJson(data);
    } else {
      // Handle null data (e.g. keep empty, or show error)
      subscriber.value = Subscriber.empty();
    }
  }

  Future<void> fetchIdentityDocument() async {
    isLoading.value = true;
    try {
      final doc = await SubscriberApi.fetchIdentityDocument();
      if (doc != null) {
        identityDocument.value = doc;
      } else {
        Get.snackbar('Erreur', 'Aucun document trouvé');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors du chargement');
    } finally {
      isLoading.value = false;
    }
  }
  void logout() {
    AuthApi.logout();
    Get.offAllNamed('/login');
  }
}
