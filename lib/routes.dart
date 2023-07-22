import 'package:get/get.dart';
import 'package:opencarssooq/views/screens/add_car_screen.dart';
import 'package:opencarssooq/views/screens/add_offer_screen.dart';
import 'package:opencarssooq/views/screens/add_rating_screen.dart';
import 'package:opencarssooq/views/screens/auth/confirm_password_screen.dart';
import 'package:opencarssooq/views/screens/auth/forgot_password_screen.dart';
import 'package:opencarssooq/views/screens/auth/otp_verification_screen.dart';
import 'package:opencarssooq/views/screens/auth/sign_up_screen.dart';
import 'package:opencarssooq/views/screens/auth/sign_up_store_screen.dart';
import 'package:opencarssooq/views/screens/car_details_screen.dart';
import 'package:opencarssooq/views/screens/edit_car_screen.dart';
import 'package:opencarssooq/views/screens/edit_offer_screen.dart';
import 'package:opencarssooq/views/screens/edit_store_screen.dart';
import 'package:opencarssooq/views/screens/help_center_screen.dart';
import 'package:opencarssooq/views/screens/language_screen.dart';
import 'package:opencarssooq/views/screens/main_screen.dart';
import 'package:opencarssooq/views/screens/profile_screen.dart';
import 'package:opencarssooq/views/screens/store_details_screen.dart';
import 'core/constant/app_route.dart';
import 'core/middleware/app_middleware.dart';
import 'views/screens/auth/login_screen.dart';

List<GetPage<dynamic>>? routes = [
  /** Auth **/
  GetPage(name: AppRoute.loginScreen, page: () => const LoginScreen(), middlewares: [AppMiddleware()]),
  GetPage(name: AppRoute.signUpScreen, page: () => const SignUpScreen()),
  GetPage(name: AppRoute.signUpStoreScreen, page: () => const SignUpStoreScreen()),
  GetPage(name: AppRoute.forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
  GetPage(name: AppRoute.otpVerificationScreen, page: () => const OTPVerificationScreen()),
  GetPage(name: AppRoute.confirmPasswordScreen, page: () => const ConfirmPasswordScreen()),
  /** Main **/
  GetPage(name: AppRoute.mainScreen, page: () => const MainScreen()),
  /** Profile **/
  GetPage(name: AppRoute.profileScreen, page: () => const ProfileScreen()),
  /** Language **/
  GetPage(name: AppRoute.languageScreen, page: () => LanguageScreen()),
  /** Help Center **/
  GetPage(name: AppRoute.helpCenterScreen, page: () => HelpCenterScreen()),
  /** Store Details **/
  GetPage(name: AppRoute.storeDetailsScreen, page: () => const StoreDetailsScreen()),
  GetPage(name: AppRoute.editStoreScreen, page: () => const EditStoreScreen()),
  /** Car Details **/
  GetPage(name: AppRoute.carDetailsScreen, page: () => CarDetailsScreen()),
  /** Add car **/
  GetPage(name: AppRoute.addCarScreen, page: () => const AddCarScreen()),
  GetPage(name: AppRoute.editCarScreen, page: () => const EditCarScreen()),
  /** Add offer **/
  GetPage(name: AppRoute.addOfferScreen, page: () => const AddOfferScreen()),
  GetPage(name: AppRoute.editOfferScreen, page: () => EditOfferScreen()),
  /** Add rating **/
  GetPage(name: AppRoute.addFeedbackScreen, page: () => const AddFeedbackScreen()),
];