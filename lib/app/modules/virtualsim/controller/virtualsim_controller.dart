import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:firstgetxapp/app/models/profile_model.dart';
import 'package:firstgetxapp/app/modules/profil/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:firstgetxapp/app/models/virtualsim_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VirtualSimController extends GetxController {
  RxList<VirtualSim> virtualSims = <VirtualSim>[].obs;
  RxBool isLoading = false.obs;

  final RxString selectedStatus = 'All'.obs;
  final RxString selectedProfile = 'All'.obs;

  final ProfileController profileController = Get.find();
  final Map<int, Profile> _profileCache = {};
  final RxMap<int, String> profileNames = <int, String>{}.obs;

  List<VirtualSim> get filteredVirtualSims {
    return virtualSims.where((sim) {
      final statusMatch = selectedStatus.value == 'All' || sim.msisdn == selectedStatus.value;
      final profileMatch = selectedProfile.value == 'All' || profileNames[sim.profileId] == selectedProfile.value;
      return statusMatch && profileMatch;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchVirtualSims();
  }

Future<void> fetchVirtualSims() async {
  isLoading.value = true;
  try {
    final headers = await ApiConfig.getHeaders();
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/subscriber/virtual-sim-cards'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> simsJson = data['virtual_sim_cards'];

      virtualSims.value = simsJson.map((json) => VirtualSim.fromJson(json)).toList();

      // Optional: cache profile names
      for (var sim in virtualSims) {
        await getProfileById(sim.profileId);
      }
    } else {
      print('Failed to fetch subscriber virtual SIM cards: ${response.body}');
    }
  } catch (e) {
    print('Error fetching subscriber virtual SIM cards: $e');
  } finally {
    isLoading.value = false;
  }
}


  Future<Profile?> getProfileById(int profileId) async {
    if (_profileCache.containsKey(profileId)) {
      return _profileCache[profileId];
    } else {
      await profileController.fetchProfileById(profileId);
      final profile = profileController.selectedProfile.value;
      if (profile != null) {
        _profileCache[profileId] = profile;
        profileNames[profileId] = profile.commercialName;
      }
      return profile;
    }
  }

  // Filter support methods
  void setStatusFilter(String status) {
    selectedStatus.value = status;
  }

  void setProfileFilter(String profileName) {
    selectedProfile.value = profileName;
  }

  List<String> getAvailableStatuses() {
    final statuses = virtualSims.map((sim) => sim.msisdn).toSet().toList();
    statuses.sort();
    return ['All', ...statuses];
  }

  List<String> getAvailableProfiles() {
    final profiles = profileNames.values.toSet().toList();
    profiles.sort();
    return ['All', ...profiles];
  }
}
