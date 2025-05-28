
import 'package:firstgetxapp/app/modules/combination/view/Combine_view.dart';
import 'package:firstgetxapp/app/modules/forfait/views/forfait_view.dart';
import 'package:firstgetxapp/app/modules/profile/ProfileView.dart';
import 'package:get/get.dart';
import 'package:firstgetxapp/app/modules/home/views/home_view.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final pages = [
    HomeView(),
    CombineView(), // Example of another view
    ForfaitView(), // Example of another view
    const ProfileView(), // Example of another view
  ];

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
