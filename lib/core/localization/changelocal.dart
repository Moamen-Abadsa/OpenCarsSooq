import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/shared_preference_keys.dart';
import '../services/services.dart';

class LocalController extends GetxController {

  Locale? language;

  AppServices myServices = Get.find();

  changeLang(String languageCode) {
      Locale locale = Locale(languageCode);
      myServices.sharedPreferences.setString(SharedPrefKeys.LANG, languageCode);
      Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = myServices.sharedPreferences.getString(SharedPrefKeys.LANG);

    if(sharedPrefLang == "ar") {
      language = const Locale("ar");
    } else if(sharedPrefLang == "en") {
      language = const Locale("en");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }

    super.onInit();
  }

}