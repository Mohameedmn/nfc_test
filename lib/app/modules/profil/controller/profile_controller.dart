import 'package:firstgetxapp/app/core/utils/api/api_config.dart';
import 'package:get/get.dart';
import 'package:firstgetxapp/app/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileController extends GetxController {
  RxList<Profile> profiles = <Profile>[].obs;
  RxMap<int, Profile> profilesMap = <int, Profile>{}.obs;
  Rx<Profile?> selectedProfile = Rx<Profile?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfiles(); // optional
  }

  Future<void> fetchProfiles() async {
    isLoading.value = true;

    try {
      final headers = await ApiConfig.getHeaders();
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/profiles'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final loadedProfiles = data.map((json) => Profile.fromJson(json)).toList();

        profiles.value = loadedProfiles;

        // Fill the map
        for (var profile in loadedProfiles) {
          profilesMap[profile.id] = profile;
          
        }
      } else {
        print('Failed to fetch profiles: ${response.body}');
      }
    } catch (e) {
      print('Error fetching profiles: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProfileById(int id) async {
    // Avoid re-fetching if already in the map
    if (profilesMap.containsKey(id)) return;

    isLoading.value = true;

    try {
      final headers = await ApiConfig.getHeaders();
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/profiles/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final profile = Profile.fromJson(data);
        selectedProfile.value = profile;
        profilesMap[profile.id] = profile; // cache it
      } else {
        print('Failed to fetch profile: ${response.body}');
      }
    } catch (e) {
      print('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
