import 'package:firstgetxapp/app/routes/app_routes.dart';
import 'package:firstgetxapp/app/widgets/CustomTextField.dart';
import 'package:firstgetxapp/app/widgets/custombutton.dart';
import 'package:firstgetxapp/app/widgets/djezzyappbar.dart';
import 'package:firstgetxapp/app/modules/login/controllers/logincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DjeezyAppBar(),
        body: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            Card(
              color: const Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 10,
                  ),
                  const Text(
                    'Welcome Back !',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Container(
                    height: 30,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'PHONE NUMBER',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  CustomTextField(
                    label: 'Phone Number',
                    hint: 'Enter your phone number',
                    icon: Icons.phone,
                    controllerRx: loginController.phonenumber,
                    obscureText: false,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'PASSWORD',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  CustomTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.lock,
                    controllerRx: loginController.password,
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'remember me',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.RECOVER);  
                          },
                          child: const Text(
                            'forgot password?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      loginController.login();
                    },
                    color: Colors.red,
                    width: 320,
                  ),
                  Container(
                    height: 50,
                  ),
                ],
              ),
            ),
            const Center(child: Text("You dont have an account?")),
            Center(
                child: GestureDetector(
              onTap: () {
                 Get.toNamed(Routes.REGISTER); 
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 0, 0),
                ),
              ),
            )),
          ],
        ));
  }
}
