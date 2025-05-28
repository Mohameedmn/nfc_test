import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var currentPage = 0.obs;
  late final PageController pageController;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  void changePage(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (pageController.hasClients && currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void goToLogin() {
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
