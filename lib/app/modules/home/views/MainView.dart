import 'package:firstgetxapp/app/modules/home/controllers/BottomNavController.dart';
import 'package:firstgetxapp/app/modules/infos/controllers/infos_controller.dart';
import 'package:firstgetxapp/app/modules/subscriber/controller/subscriber_controller.dart';
import 'package:firstgetxapp/app/widgets/BottomNavBar.dart';
import 'package:firstgetxapp/app/widgets/ProfilAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  final bottomnavcontroller = Get.find<BottomNavController>();
  final subscriberController = Get.find<SubscriberController>();
  final infoscontroller = Get.find<InfosController>();

  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            kToolbarHeight), // or your ProfileAppBar height
        child: Obx(() {
          final subscriber = subscriberController.subscriber.value;
          final identityDocument = infoscontroller.identityDocument.value;

          final name =
              '${identityDocument?.lastName ?? ''} ${identityDocument?.firstName ?? ''}'
                  .trim();

          final phone = subscriber?.phoneNumber;

          return ProfileAppBar(
            name: name,
            phoneNumber: phone ?? 'Unknown',
            pathImage: 'assets/images/profile_image.png',
          );
        }),
      ),
      body: Obx(() =>
          bottomnavcontroller.pages[bottomnavcontroller.selectedIndex.value]),
      bottomNavigationBar: DjezzyBottomNavigationBar(),
    );
  }
}
