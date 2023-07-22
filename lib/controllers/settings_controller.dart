import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/core/constant/shared_preference_keys.dart';

import '../core/class/status_request.dart';
import '../core/constant/app_route.dart';
import '../core/services/services.dart';
import '../data/models/rated_store.dart';
import '../data/models/store_rating.dart';
import '../data/models/store.dart';

abstract class SettingsController extends GetxController {
  goToMyAccount();

  goToMyStore();

  gotToLanguage();

  gotToHelpCenter();

  logout();
}

class SettingsControllerImp extends SettingsController {
  AppServices appServices = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToMyAccount() {
    Get.toNamed(AppRoute.profileScreen);
  }

  @override
  goToMyStore() {
    Get.toNamed(AppRoute.storeDetailsScreen, arguments: {
      'storeId': appServices.getStringSharedPreferences(SharedPrefKeys.STORE_ID)
    });
  }

  @override
  gotToLanguage() {
    Get.toNamed(AppRoute.languageScreen);
  }

  @override
  gotToHelpCenter() {
    Get.toNamed(AppRoute.helpCenterScreen);
  }

  @override
  logout() {
    appServices.sharedPreferences.setBool(SharedPrefKeys.IS_REMEMBER_ME, false);
    appServices.sharedPreferences.setString(SharedPrefKeys.USER_ID, '');
    appServices.sharedPreferences.setString(SharedPrefKeys.USER_NAME, '');
    appServices.sharedPreferences.setString(SharedPrefKeys.USER_EMAIL, '');
    appServices.sharedPreferences.setString(SharedPrefKeys.USER_ADDRESS, '');
    appServices.sharedPreferences.setString(SharedPrefKeys.USER_PHONE, '');

    Get.offNamed(AppRoute.loginScreen);
  }

}
