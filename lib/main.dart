import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firstgetxapp/app/routes/app_pages.dart'; // Routes and pages
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  // Initialize the HomeController*
  await initializeDateFormatting('fr_FR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Djezzy App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ), // Define the routes
    );
  }
}
