import 'package:get/get.dart';
import 'controllers/car_controller.dart';
import 'controllers/car_offer_controller.dart';
import 'controllers/favorite_cars_controller.dart';
import 'controllers/feedback_controller.dart';
import 'controllers/forgot_password_controller.dart';
import 'controllers/help_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/main_controller.dart';
import 'controllers/otp_controller.dart';
import 'controllers/reset_password_cotroller.dart';
import 'controllers/search_controller.dart';
import 'controllers/settings_controller.dart';
import 'controllers/signup_controller.dart';
import 'controllers/signup_store_controller.dart';
import 'controllers/store_controller.dart';
import 'core/class/crud.dart';

class AppDataBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(Crud());
    Get.lazyPut(() => SignUpControllerImp(), fenix: true);
    Get.lazyPut(() => SignUpStoreControllerImp(), fenix: true);
    Get.lazyPut(() => LoginControllerImp(), fenix: true);
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => HomeControllerImp(), fenix: true);
    Get.lazyPut(() => SettingsControllerImp(), fenix: true);
    Get.lazyPut(() => StoreControllerImp(), fenix: true);
    Get.lazyPut(() => CarControllerImp(), fenix: true);
    Get.lazyPut(() => FeedbackControllerImp(), fenix: true);
    Get.lazyPut(() => FavoriteCarControllerImp(), fenix: true);
    Get.lazyPut(() => ForgotPasswordControllerImp(), fenix: true);
    Get.lazyPut(() => ResetPasswordControllerImp(), fenix: true);
    Get.lazyPut(() => OtpControllerImp(), fenix: true);
    Get.lazyPut(() => CarOfferControllerImp(), fenix: true);
    Get.lazyPut(() => SearchControllerImp(), fenix: true);
    Get.lazyPut(() => HelpControllerImp(), fenix: true);
  }

}