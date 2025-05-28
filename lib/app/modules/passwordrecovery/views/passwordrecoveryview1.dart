import 'package:firstgetxapp/app/modules/passwordrecovery/controllers/passwordrecoverycontroller.dart';
import 'package:firstgetxapp/app/widgets/CustomTextField.dart';
import 'package:firstgetxapp/app/widgets/custombutton.dart';
import 'package:firstgetxapp/app/widgets/djezzyappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryView1 extends GetView<PasswordRecoveryController> {
  PasswordRecoveryView1({super.key});

  final RecoveryController = Get.find<PasswordRecoveryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DjeezyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(child: Icon(Icons.lock, size: 60, color: Colors.red)),
            const SizedBox(height: 20),
            const Text('Forgot your password?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0))),
            const SizedBox(height: 20),
            const Text(
              'No problem! Enter your phone number and we\'ll send you an sms to reset your password',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            CustomTextField(
              label: 'Phone Number',
              hint: 'Enter your phone number',
              icon: Icons.phone,
              controllerRx: RecoveryController.phoneNumber,
              obscureText: false,
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Validate',
              onPressed: () {
                RecoveryController.validatePhoneNumber();
              },
              color: Colors.red,
              width: 320,
            ),
            const SizedBox(height: 20),
            Center(
                child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Text(
                'Return to login',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 0, 0),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
