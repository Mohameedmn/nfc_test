import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:get/get.dart';
import 'package:firstgetxapp/app/models/offer_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForfaitController extends GetxController {
  RxList<Offer> offers = <Offer>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchOffers();
    super.onInit();
  }

  Future<void> fetchOffers() async {
    isLoading.value = true;

    try {
      final headers = await ApiConfig.getHeaders();
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/offers'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        offers.value = data.map((json) => Offer.fromJson(json)).toList();
      } else {
        print('Failed to fetch offers: ${response.body}');
      }
    } catch (e) {
      print('Error fetching offers: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
