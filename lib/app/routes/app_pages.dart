import 'package:firstgetxapp/app/modules/Purchase_request/bindings/Purchase_request_binding.dart';
import 'package:firstgetxapp/app/modules/Purchase_request/view/Purchqse_request_view.dart';
import 'package:firstgetxapp/app/modules/help/bindings/help_bindings.dart';
import 'package:firstgetxapp/app/modules/help/view/help_view.dart';
import 'package:firstgetxapp/app/modules/home/bindings/main_bindings.dart';
import 'package:firstgetxapp/app/modules/home/views/MainView.dart';
import 'package:firstgetxapp/app/modules/infos/bindings/infos_binding.dart';
import 'package:firstgetxapp/app/modules/infos/views/infos_view.dart';
import 'package:firstgetxapp/app/modules/selfie/bindings/selfie_CNI_binding.dart';
import 'package:firstgetxapp/app/modules/selfie/bindings/selfie_FACEIDB_binding.dart';
import 'package:firstgetxapp/app/modules/selfie/views/compare_view.dart';
import 'package:firstgetxapp/app/modules/selfie/views/testView.dart';
import 'package:firstgetxapp/app/modules/stepper/views/recap.dart';
import 'package:get/get.dart';
import 'package:firstgetxapp/app/modules/home/bindings/home_binding.dart';
import 'package:firstgetxapp/app/modules/home/views/home_view.dart';
import 'package:firstgetxapp/app/modules/stepper/bindings/stepper_binding.dart';
import 'package:firstgetxapp/app/modules/stepper/views/step1_view.dart';
import 'package:firstgetxapp/app/modules/stepper/views/step2_view.dart';
import 'package:firstgetxapp/app/modules/stepper/views/step3_view.dart';

import 'package:firstgetxapp/app/modules/forfait/bindings/forfait_binding.dart';
import 'package:firstgetxapp/app/modules/forfait/views/forfait_view.dart';
import 'package:firstgetxapp/app/modules/selfie/views/CNI_view1.dart';
import 'package:firstgetxapp/app/modules/selfie/bindings/faceCompare_binding.dart';

import 'package:firstgetxapp/app/modules/passwordrecovery/bindings/passwordrecoverybinding.dart';
import 'package:firstgetxapp/app/modules/passwordrecovery/views/passwordrecoveryview1.dart';
import 'package:firstgetxapp/app/modules/register/bindings/registerbinding.dart';
import 'package:firstgetxapp/app/modules/register/views/registerpage.dart';
import 'package:firstgetxapp/app/modules/welcome/bindings/welcomebinding.dart';
import 'package:firstgetxapp/app/modules/welcome/views/welcomeview.dart';
import 'package:firstgetxapp/app/modules/login/bindings/loginbinding.dart';
import 'package:firstgetxapp/app/modules/login/views/loginpage.dart'; // Make sure to import your LoginView

class AppPages {
  static const INITIAL = Routes.step1; // Define the initial route

  static final routes = [

    GetPage(
      name: Routes.MAIN,
      page: () => MainView(), // The view to display
      binding: MainBinding(), // The binding to use for this route
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(), // The view to display
      binding: HomeBinding(), // The binding to use for this route
    ),
    GetPage(
      name: Routes.step1,
      page: () => const Step1View(),
      binding: StepperBinding(),
    ),
    GetPage(
      name: Routes.step2,
      page: () => const Step2View(),
      binding: StepperBinding(),
    ),
    GetPage(
      name: Routes.step3,
      page: () =>  Step3View(),
      binding: StepperBinding(),
    ),
    GetPage(
      name: Routes.recap,
      page: () => const RecapView(),
      binding: StepperBinding(),
    ),
    GetPage(
      name: Routes.FORFAIT,
      page: () => ForfaitView(),
      binding: ForfaitBinding(),
    ),
    GetPage(
      name: Routes.selfie_CNI,
      page: () => const CniView1(),
      binding: SelfieCNIBinding(),
    ),
    GetPage(
      name: Routes.selfie_FACEID,
      page: () => const testView1(),
      binding: SelfieFACEIDBinding(),
    ),
    GetPage(
      name: Routes.selfie_compare,
      page: () => CompareView(),
      binding: FaceCompareBinding(),
    ),
    GetPage(
      name: Routes
          .LOGIN, // Correct the route name here to match your actual route name
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(), // this is important!
    ),
    GetPage(
      name: Routes.RECOVER,
      page: () => PasswordRecoveryView1(),
      binding: PasswordRecoveryBinding(),
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => Welcomeview(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: Routes.INFOS,
      page: () => InfosView(),
      binding: InfosBinding(),
    ),
    GetPage(
      name: Routes.PURCHASE_REQUEST,
      page: () => PurchaseRequestView(),
      binding: PurchaseRequestBinding(),
    ),
    GetPage(
      name: Routes.HELP,
      page: () => const HelpView(),
      binding: HelpBindings(),
    ),




  ];
}

class Routes {
  static const MAIN = '/main'; // Define your route names here
  static const HOME = '/home'; // Define your route names here
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const RECOVER = '/recover';
  static const WELCOME = '/welcome';
  static const step1 = '/step1';
  static const step2 = '/step2';
  static const step3 = '/step3';
  static const FORFAIT = '/forfait';
  static const selfie_CNI = '/selfie-CNI';
  static const selfie_FACEID = '/selfie-FACEID';
  static const recap = '/recap';
  static const selfie_compare = '/selfie-compare';
  static const INFOS = '/infos';
  static const PURCHASE_REQUEST = '/purchase-request';
  static const HELP = '/help';

}
