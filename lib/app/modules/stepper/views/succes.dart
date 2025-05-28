import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stepper_controller.dart';

class SuccesView extends GetView<StepperController> {
  const SuccesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: const Text("Sucess"),
        
        
      ),
    );
  }
}
