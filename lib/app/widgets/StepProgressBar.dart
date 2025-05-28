import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StepperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final RxInt currentStep;
  final int totalSteps;
  String steptitle;

  StepperAppBar({super.key, required this.currentStep, required this.totalSteps , required this.steptitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Obx(() => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              //color: const Color.fromARGB(   255, 60, 255, 0), // Background color of the AppBar
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text(
                  steptitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                // Center the LinearPercentIndicator in the AppBar
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    //color: const Color.fromARGB(255, 195, 12                236), // Background color of the progress bar
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: Container(
                    //margin: const EdgeInsets.only(left: 25),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: LinearPercentIndicator(
                      width: 300.0, // Set the width of the progress bar
                      lineHeight: 6.0, // Set the height of the progress bar
                      percent: currentStep.value /
                          totalSteps, // Calculate the progress based on current step
                      backgroundColor: Colors
                          .grey[300], // Background color of the progress bar
                      progressColor: Colors.red, // Progress color of the bar
                      barRadius: const Radius.circular(
                          3), // Rounded corners for the progress bar
                      animation: true, // Enable animation for smooth transition
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 50); // Adjusted height for better centering
}
