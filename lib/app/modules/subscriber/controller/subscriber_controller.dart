import 'package:firstgetxapp/app/core/utils/api/subscriber_api.dart' as SubscriberApi;
import 'package:get/get.dart';
import 'package:firstgetxapp/app/models/subscriber_model.dart';
import 'package:firstgetxapp/app/models/identitydocument_model.dart';

class SubscriberController extends GetxController {
  Rxn<Subscriber> subscriber = Rxn<Subscriber>();
  Rxn<IdentityDocument> identityDocument = Rxn<IdentityDocument>();
  RxBool isLoading = false.obs;
  RxBool isIdentityLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentSubscriber();
    fetchIdentityDocument();
  }

  Future<void> fetchCurrentSubscriber() async {
    isLoading.value = true;

    try {
      final data = await SubscriberApi.getCurrentSubscriber();
      if (data != null) {
        subscriber.value = Subscriber.fromJson(data);
      } else {
        Get.snackbar('Erreur', 'Impossible de charger le profil de l\'abonné');
      }
    } catch (e) {
      print('Erreur lors de la récupération du subscriber: $e');
      Get.snackbar('Erreur', 'Une erreur est survenue');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchIdentityDocument() async {
    isIdentityLoading.value = true;

    try {
      final doc = await SubscriberApi.fetchIdentityDocument();
      if (doc != null) {
        identityDocument.value = doc;
      } else {
        Get.snackbar('Erreur', 'Aucun document d\'identité trouvé');
      }
    } catch (e) {
      print('Erreur lors de la récupération du document: $e');
      Get.snackbar('Erreur', 'Impossible de charger le document');
    } finally {
      isIdentityLoading.value = false;
    }
  }
}
