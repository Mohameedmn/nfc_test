import 'package:firstgetxapp/app/modules/Purchase_request/bindings/Purchase_request_binding.dart';
import 'package:firstgetxapp/app/modules/Purchase_request/view/Purchqse_request_view.dart';
import 'package:firstgetxapp/app/modules/home/bindings/main_bindings.dart';
import 'package:firstgetxapp/app/modules/home/views/MainView.dart';
import 'package:firstgetxapp/app/modules/infos/bindings/infos_binding.dart';
import 'package:firstgetxapp/app/modules/infos/views/infos_view.dart';
import 'package:firstgetxapp/app/modules/selfie/bindings/selfie_FACEIDB_binding.dart';
import 'package:firstgetxapp/app/modules/selfie/views/compare_view.dart';
import 'package:firstgetxapp/app/modules/selfie/views/faceID_view1.dart';
import 'package:firstgetxapp/app/modules/stepper/views/OriginalStep1.dart';
import 'package:firstgetxapp/app/modules/stepper/views/failure.dart';
import 'package:firstgetxapp/app/modules/stepper/views/recap.dart';
import 'package:firstgetxapp/app/modules/stepper/views/succes.dart';
import 'package:get/get.dart';
import 'package:firstgetxapp/app/modules/home/bindings/home_binding.dart';
import 'package:firstgetxapp/app/modules/home/views/home_view.dart';
import 'package:firstgetxapp/app/modules/stepper/bindings/stepper_binding.dart';
import 'package:firstgetxapp/app/modules/stepper/views/step1_view.dart';
import 'package:firstgetxapp/app/modules/stepper/views/step2_view.dart';
import 'package:firstgetxapp/app/modules/stepper/views/step3_view.dart';
import 'package:firstgetxapp/app/modules/forfait/bindings/forfait_binding.dart';
import 'package:firstgetxapp/app/modules/forfait/views/forfait_view.dart';
import 'package:firstgetxapp/app/modules/passwordrecovery/bindings/passwordrecoverybinding.dart';
import 'package:firstgetxapp/app/modules/passwordrecovery/views/passwordrecoveryview1.dart';
import 'package:firstgetxapp/app/modules/register/bindings/registerbinding.dart';
import 'package:firstgetxapp/app/modules/register/views/registerpage.dart';
import 'package:firstgetxapp/app/modules/welcome/bindings/welcomebinding.dart';
import 'package:firstgetxapp/app/modules/welcome/views/welcomeview.dart';
import 'package:firstgetxapp/app/modules/login/bindings/loginbinding.dart';
import 'package:firstgetxapp/app/modules/login/views/loginpage.dart'; 
import 'package:firstgetxapp/app/routes/app_routes.dart'; 



class AppPages {
  static const INITIAL = Routes.LOGIN; // Define the initial route

  static final routes = [

    GetPage(
      name: Routes.MAIN,
      page: () => MainView(), 
      binding: MainBinding(), 
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(), // The view to display
      binding: HomeBinding(), // The binding to use for this route
    ),

    GetPage(
      name: Routes.ORIGINAL_STEP1,
      page: () =>  const Originalstep1() 
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
    /*
    GetPage(
      name: Routes.selfie_CNI,
      page: () => const CniView1(),
      binding: SelfieCNIBinding(),
    ),
    */
    
    GetPage(
      name: Routes.selfie_FACEID,
      page: () => const SelfieView1(),
      binding: SelfieFACEIDBinding(),
    ),
    
    
    GetPage(
      name: Routes.selfie_compare,
      page: () => UploadScreen(),
      binding: SelfieFACEIDBinding(),
    ),


    GetPage(
      name: Routes.SUCCES,
      page: () => const SuccesView(),
      binding: StepperBinding(), // Ensure you have the correct binding for this view
    ),

      //FailureView

      GetPage(
      name: Routes.FAILURE,
      page: () => const FailureView(),
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
    /*
    GetPage(
      name: Routes.HELP,
      page: () => const HelpView(),
      binding: HelpBindings(),
    ),
    */

    



  ];
}

