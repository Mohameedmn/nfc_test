import 'package:firstgetxapp/app/modules/home/controllers/BottomNavController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DjezzyBottomNavigationBar extends StatelessWidget {
  
  final BottomNavController controller = Get.find();

  DjezzyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTab,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red, // Djezzy red
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Usage'),
            BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Rewards'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ));
  }
}
