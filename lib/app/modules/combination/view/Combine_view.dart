import 'package:firstgetxapp/app/modules/Purchase_request/view/Purchqse_request_view.dart';
import 'package:firstgetxapp/app/modules/combination/controllers/Combine_controller.dart';
import 'package:firstgetxapp/app/modules/virtualsim/controller/virtualsim_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CombineView extends StatelessWidget {
  final CombineController controller = Get.put(CombineController());

  CombineView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: null,
            elevation: 0,
            bottom: const TabBar(
              labelColor: Colors.red,
              indicatorColor: Colors.red,
              tabs: [
                Tab(text: 'Mes Sims virtuelles'),
                Tab(text: 'Mes Demandes'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            VirtualSimView(),
            PurchaseRequestView(),
          ],
        ),
      ),
    );
  }
}
