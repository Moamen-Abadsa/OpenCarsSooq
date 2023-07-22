import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/app_route.dart';
import '../constant/shared_preference_keys.dart';
import '../services/services.dart';

class AppMiddleware extends GetMiddleware {
  AppServices appServices = Get.find();

  @override
  // TODO: implement priority
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (appServices.sharedPreferences.getBool(SharedPrefKeys.IS_REMEMBER_ME) == true) {
      return const RouteSettings(name: AppRoute.mainScreen);
    }
    return null;
  }
}
