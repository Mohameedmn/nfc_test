import 'package:firstgetxapp/app/widgets/Onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/welcomecontroller.dart';


class Welcomeview extends StatelessWidget {
  Welcomeview({super.key});

    final welcomecontroller = Get.find<WelcomeController>();


  @override
  final List<Widget> pages = [
    const OnboardingPage(
      title: 'Welcome to',
      subtitle: 'Djezzy eSim',
      imagePath: 'assets/images/onboarding_page1.png',
      description: 'Your digital gateway to instant connectivity...',

    ),
    const OnboardingPage(
      title: 'Activate Your eSIM',
      subtitle: 'Fast & Secure',
      imagePath: 'assets/images/onboarding_page2.png',
      description: 'Scan, verify, and connect in a few taps.',

    ),
    const OnboardingPage(
      title: 'Stay Connected',
      subtitle: 'Anywhere, Anytime',
      imagePath: 'assets/images/onboarding_page3.png',
      description: 'Manage your plans with full control.',

    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: welcomecontroller.pageController,
                onPageChanged: welcomecontroller.changePage,
                itemCount: pages.length,
                itemBuilder: (context, index) => pages[index],
              ),
            ),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) {
                return Container(
                  margin: const EdgeInsets.all(6),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: welcomecontroller.currentPage.value == index
                        ? Colors.red
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            )),
            const SizedBox(height: 20),
            Obx(() {
              return welcomecontroller.currentPage.value == 2
                  ? TextButton(
                      onPressed: welcomecontroller.goToLogin,
                      child: const Text("Get Started", style: TextStyle(fontSize: 18, color: Colors.red)),
                    )
                  : TextButton(
                      onPressed: welcomecontroller.nextPage,
                      child: const Text("Next", style: TextStyle(fontSize: 18, color: Colors.red)),
                    );
            }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
