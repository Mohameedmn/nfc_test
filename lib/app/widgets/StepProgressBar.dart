import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StepperAppBar extends StatelessWidget {
  final RxInt currentStep;
  final int totalSteps;
  final String steptitle;

  const StepperAppBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.steptitle,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              steptitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: LinearPercentIndicator(
                lineHeight: 6.5,
                percent: currentStep.value / totalSteps,
                backgroundColor: Colors.grey[300],
                progressColor: Colors.red,
                barRadius: const Radius.circular(4),
                animation: true,
              ),
            ),
          ],
        ));
  }
}