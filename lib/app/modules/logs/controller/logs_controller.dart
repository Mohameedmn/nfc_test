import 'package:firstgetxapp/app/core/utils/api/logs_api.dart';
import 'package:firstgetxapp/app/models/logs_model.dart';
import 'package:get/get.dart';

class LogsController extends GetxController {
  var isLoading = false.obs;
  var logsList = <Logs>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLogs();
  }

  Future<void> fetchLogs() async {
    try {
      isLoading.value = true;
      final data = await LogsApi.getMyLogs();
      logsList.value = data.map<Logs>((json) => Logs.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching logs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createLog({
  required String action,
  required String actionType,
}) async {
  final success = await LogsApi.createLog(
    action: action,
    actionType: actionType,
  );

  if (success) {
    print('Log created: $action ($actionType)');
    fetchLogs(); // Optional
  } else {
    print('Failed to create log');
  }
}


}
