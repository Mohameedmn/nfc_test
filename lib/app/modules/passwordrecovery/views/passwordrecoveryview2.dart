import 'package:firstgetxapp/app/modules/passwordrecovery/controllers/passwordrecoverycontroller.dart';
import 'package:firstgetxapp/app/widgets/CustomTextField.dart';
import 'package:firstgetxapp/app/widgets/custombutton.dart';
import 'package:firstgetxapp/app/widgets/djezzyappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryView2 extends StatelessWidget {
  final PasswordRecoveryController recoverycontroller =
      Get.put(PasswordRecoveryController());

  PasswordRecoveryView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DjeezyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Center(child: Icon(Icons.lock, size: 60, color: Colors.red)),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Choose a new, secure password to access your account.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),

            CustomTextField(
              label: 'New Password',
              hint: 'Enter your password',
              icon: Icons.lock,
              controllerRx: recoverycontroller.newPassword,
              obscureText: true,
            ),
            const SizedBox(height: 8),

            CustomTextField(
              label: 'Confirm New Password',
              hint: 'Confirm your password',
              icon: Icons.lock,
              controllerRx: recoverycontroller.confirmPassword,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            const Text("✔️ At least 8 characters"),
            const Text("✔️ One uppercase letter"),
            const Text("✔️ One lowercase letter"),
            const Text("✔️ One digit"),
            const Text("✔️ One special character"),

            const SizedBox(height: 30),

            // Submit button
            CustomButton(
              text: 'reset password',
              onPressed: () {
                recoverycontroller.resetPassword();
              },
              color: Colors.red,
              width: 320,
            ),

            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Text(
                  "Return to login",
                  style: TextStyle(
                    color: Colors.black54,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
